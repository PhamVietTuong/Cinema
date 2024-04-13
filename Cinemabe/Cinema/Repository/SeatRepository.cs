using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
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

		public async Task<List<SeatViewModel>> GetSeatByShowTimeAysn(Guid showTimeId)
		{
			var seats = await _context.Seats
											.Include(x => x.TicketType)
												.ThenInclude(x => x.SeatType)
											.Where(x => x.ShowTimeId == showTimeId)
											.ToListAsync();
			var rowName = seats.GroupBy(x => new { x.RowName })
								.Select(rowNameViewModel => new SeatViewModel
								{
									RowName = rowNameViewModel.Key.RowName,
									RowSeats = rowNameViewModel.Select(rowSeatViewModel => new RowSeatViewModel
									{
										Id = rowSeatViewModel.Id,
										ColIndex = rowSeatViewModel.ColIndex,
										IsSold = rowSeatViewModel.IsSold,
										Name = rowSeatViewModel.Name,
										SeatTypeName = rowSeatViewModel.TicketType?.SeatType.Name,
										TicketTypeId = rowSeatViewModel.TicketType?.Id ?? Guid.Empty,
										TicketTypeName = rowSeatViewModel.TicketType?.Name,
										Price = rowSeatViewModel.TicketType?.Price ?? 0.0,
									})
									.OrderBy(x => x.IsSold).ThenBy(x => x.Name)
									.ToList()
								})
								.OrderBy(x => x.RowName)
								.ToList();

			return rowName;
		}
	}
}
