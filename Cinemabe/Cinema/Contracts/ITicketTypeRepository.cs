using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface ITicketTypeRepository
	{
		Task<List<TicketTypeViewModel>> TicketTypeByShowTimeAndRoomAsync(TicketTypeByShowTimeAndRoomDTO vm);
        Task<List<TicketTypeDTO>> GetTicketTypeListAsync();
        Task<bool> ExistsAsync(Guid id);
        Task<TicketTypeDTO> UpdateAsync(TicketTypeDTO entity);
        Task<TicketTypeDTO> CreateAsync(TicketTypeDTO entity);
    }
}
