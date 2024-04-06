using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;
using System.Net.Sockets;

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

		public async Task<bool> Exist(Guid id)
		{
			return await _context.Tickets.AnyAsync(b => b.Id == id);
		}

		public Task<TicketBookingViewModel> TicketBooking(TicketBookingViewModel vm)
		{
			return null;
		}

		public Task<Ticket> Update(Ticket request)
		{
			throw new NotImplementedException();
		}
	}
}
