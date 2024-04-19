using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ISeatRepository
	{
		Task<SeatViewModel> GetSeatByShowTimeAysn(Guid showTimeId);
	}
}
