using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ITicketRepository
	{
        Task<TicketDTO> CreateAysn(TicketDTO entity);
    }
}
