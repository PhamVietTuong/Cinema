using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ITicketTypeRepository
	{
		Task<List<TicketTypeViewModel>> TicketTypeByShowTimeAndRoomAysn(TicketTypeByShowTimeAndRoomDTO vm);
	}
}
