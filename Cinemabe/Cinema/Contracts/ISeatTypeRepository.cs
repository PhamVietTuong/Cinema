using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface ISeatTypeRepository
    {
        Task<List<SeatTypeTicketTypeRowViewModel>> GetSeatTypeTicketTypeByListSeatTypeId(List<Guid> seatTypeIds);
    }
}
