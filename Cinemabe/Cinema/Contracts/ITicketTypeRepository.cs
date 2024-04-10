using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ITicketTypeRepository
	{
		Task<List<TicketTypeViewModel>> TicketTypeByShowTimeAysn(Guid showTimeId);
	}
}
