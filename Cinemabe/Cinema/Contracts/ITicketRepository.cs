using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ITicketRepository
	{
        Task<List<TicketDTO>> CreateAysn(TicketDTO entity);
    }
}
