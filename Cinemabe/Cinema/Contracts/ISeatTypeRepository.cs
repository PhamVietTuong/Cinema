using Cinema.DTOs;
using System.Linq.Expressions;

namespace Cinema.Contracts
{
    public interface ISeatTypeRepository
    {
        Task<List<SeatTypeDTO>> GetSeatTypeListAsync();
        Task<bool> ExistsAsync(Guid id);
        Task<SeatTypeDTO> UpdateAsync(SeatTypeDTO entity);
        Task<SeatTypeDTO> CreateAsync(SeatTypeDTO entity);
    }
}
