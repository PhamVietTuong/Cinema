using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ITicketTypeRepository
	{
		Task<List<TicketTypeViewModel>> TicketTypeByShowTimeAndRoomAsync(TicketTypeByShowTimeAndRoomDTO vm);
	}
}
