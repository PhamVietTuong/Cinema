using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ITicketRepository
	{
		Task<Ticket> Create(Ticket ticket);
		Task<Ticket> Update(Ticket request);
		Task<bool> Exist(Guid id);
		Task<TicketBookingViewModel> TicketBooking(TicketBookingViewModel vm);
	}
}
