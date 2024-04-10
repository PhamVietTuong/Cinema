using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ISeatRepository
	{
		Task<List<SeatViewModel>> GetSeatByShowTimeAysn(Guid showTimeId);
	}
}
