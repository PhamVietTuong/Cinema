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

		public async Task<List<TicketTypeViewModel>> GetTicketTypeListAysn(Guid showTimeId)
		{
			var ticketTypes = await _context.TicketTypes
														.Include(x => x.ShowTime)
														.Include(x => x.SeatType).ToListAsync();
			var rows = new List<TicketTypeViewModel>();

			foreach (var ticketType in ticketTypes)
			{
				rows.Add(new TicketTypeViewModel
				{
					Id = ticketType.Id,
					Name = ticketType.Name,
					Price = ticketType.Price,
					SeatTypeName = ticketType.SeatType.Name
				});
			}

			return rows;
		}
	}
}
