using Cinema.Contracts;
using Cinema.Data;
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

		public async Task<List<TicketTypeViewModel>> TicketTypeByShowTimeAysn(Guid showTimeId)
		{
			var showTimes = await _context.ShowTime.Include(x => x.Room).FirstOrDefaultAsync(x => x.Id == showTimeId);
			var ticketTypeList = await _context.TicketType.Include(x => x.SeatType).ToListAsync();
			var seatTicketTypeIds = await _context.Seat.Where(x => x.RoomId == showTimes.RoomId).Select(x => x.TicketTypeId).ToListAsync();
			var rows = new List<TicketTypeViewModel>();

			foreach (var ticketType in ticketTypeList)
			{
				if (seatTicketTypeIds.Contains(ticketType.Id))
				{
					var vm = new TicketTypeViewModel
					{
						Id = ticketType.Id,
						Name = ticketType.Name,
						Price = ticketType.Price,
						SeatTypeName = ticketType.SeatType.Name,
					};

					rows.Add(vm);
				}
			}
			return rows;
		}
	}
}
