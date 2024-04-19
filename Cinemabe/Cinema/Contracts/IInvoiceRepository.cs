using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface IInvoiceRepository
	{
		Task<BookingDTO> CreateAysn(BookingDTO entity);
		Task<BookingDTO> FindAysn(Guid id);
	}
}
