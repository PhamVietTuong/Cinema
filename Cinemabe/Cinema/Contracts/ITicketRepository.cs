using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ITicketRepository
	{
        Task<BookingDTO> CreateAysn(BookingDTO entity);
    }
}
