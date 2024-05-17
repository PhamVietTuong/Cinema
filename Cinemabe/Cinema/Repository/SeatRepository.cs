using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class SeatRepository : ISeatRepository
	{
		private readonly CinemaContext _context;

		public SeatRepository(CinemaContext context)
		{
			_context = context;
		}

		public async Task<SeatViewModel> GetSeatByShowTimeAndRoomIdAysn(SeatByShowTimeAndRoomDTO vm)
		{
			var showTimeRoom = (await _context.ShowTimeRoom
								.Include(x => x.ShowTime)
								.Where(x => x.ShowTimeId == vm.ShowTimeId && x.RoomId == vm.RoomId)
								.ToListAsync())
								.FirstOrDefault();

			var seats = await _context.Seat
											.Include(x => x.TicketType)
												.ThenInclude(x => x.SeatType)
											.Include(x => x.Room)
											.Where(x => x.RoomId == showTimeRoom.RoomId)
											.ToListAsync();

			var ticket = await _context.Ticket.Include(x => x.Seat).Where(x => x.ShowTimeId == vm.ShowTimeId && x.Seat.RoomId == vm.RoomId).ToListAsync();

			var roomName = seats.FirstOrDefault()?.Room.Name;

			var rowName = seats.GroupBy(x => new { x.RowName })
								.Select(rowNameViewModel => new RowNameViewModel
								{
									RowName = rowNameViewModel.Key.RowName,
									RowSeats = rowNameViewModel.Select(rowSeatViewModel => new RowSeatViewModel
									{
										Id = rowSeatViewModel.Id,
										ColIndex = rowSeatViewModel.ColIndex,
										IsSeat = rowSeatViewModel.IsSeat,
										Name = rowSeatViewModel.Name,
										SeatTypeName = rowSeatViewModel.TicketType?.SeatType.Name,
										TicketTypeId = rowSeatViewModel.TicketType?.Id ?? Guid.Empty,
										TicketTypeName = rowSeatViewModel.TicketType?.Name,
										Price = rowSeatViewModel.TicketType?.Price ?? 0.0,
										IsSold = ticket.Any(x => x.SeatId == rowSeatViewModel.Id) ? true : false,
										//Đang Chọn
									})
									.OrderBy(x => x.ColIndex).ThenBy(x => x.Name)
									.ToList()
								})
								.OrderBy(x => x.RowName)
								.ToList();

			var result = new SeatViewModel
			{
				RoomName = roomName,
				RowName = rowName
			};
			return result;
		}
	}
}
