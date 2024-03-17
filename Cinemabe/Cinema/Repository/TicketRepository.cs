using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class TicketRepository : ITicketRepository
	{
		private readonly CinemaContext _context;

		public TicketRepository(CinemaContext context)
		{
			_context = context;
		}

		public async Task<Ticket> Create(Ticket ticket)
		{
			await _context.Tickets.AddAsync(ticket);
			return ticket;
		}

		public async Task<bool> Exist(int id)
		{
			return await _context.Tickets.AnyAsync(b => b.Id == id);
		}

		public Task<Ticket> Update(Ticket request)
		{
			throw new NotImplementedException();
		}
	}
}
