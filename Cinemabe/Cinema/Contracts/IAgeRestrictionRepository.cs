using Cinema.DTOs;
using System.Linq.Expressions;

namespace Cinema.Contracts
{
    public interface IAgeRestrictionRepository
    {
        Task<List<AgeRestrictionDTO>> GetAgeRestrictionListAsync();
        Task<bool> ExistsAsync(Guid id);
        Task<AgeRestrictionDTO> UpdateAsync(AgeRestrictionDTO entity);
        Task<AgeRestrictionDTO> CreateAsync(AgeRestrictionDTO entity);
    }
}
