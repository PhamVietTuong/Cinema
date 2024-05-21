using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
	public class TicketTypeRepository : ITicketTypeRepository
	{
		private readonly CinemaContext _context;

		public TicketTypeRepository(CinemaContext context)
		{
			_context = context;
		}

		public async Task<List<TicketTypeViewModel>> TicketTypeByShowTimeAndRoomAysn(TicketTypeByShowTimeAndRoomDTO ticketTypeByShowTimeDTO)
		{
			var showTimeRoom = (await _context.ShowTimeRoom.Where(x => x.ShowTimeId == ticketTypeByShowTimeDTO.ShowTimeId && x.RoomId == ticketTypeByShowTimeDTO.RoomId).ToListAsync()).FirstOrDefault();
			var seatTypeTicketTypes = await _context.SeatTypeTicketType.Include(x => x.TicketType).Include(x => x.SeatType).ToListAsync();
			var seatTypeIds = await _context.Seat.Where(x => x.RoomId == showTimeRoom.RoomId).Select(x => x.SeatTypeId).Distinct().ToListAsync();
			var rows = new List<TicketTypeViewModel>();

			foreach (var seatTypeTicketType in seatTypeTicketTypes)
			{
				if (seatTypeIds.Contains(seatTypeTicketType.SeatTypeId))
				{
					var vm = new TicketTypeViewModel
					{
                        SeatTypeId = seatTypeTicketType.SeatTypeId,
                        TicketTypeId = seatTypeTicketType.TicketTypeId,
                        TicketTypeName = seatTypeTicketType.TicketType.Name,
						Price = seatTypeTicketType.Price,
						SeatTypeName = seatTypeTicketType.SeatType.Name,
					};

					rows.Add(vm);
				}
			}
			return rows;
		}
	}
}
