using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface IUserTypeRepository
    {
        Task<List<UserTypeDTO>> GetUserTypeListAsync();
        Task<bool> ExistsAsync(Guid id);
        Task<UserTypeDTO> UpdateAsync(UserTypeDTO entity);
        Task<UserTypeDTO> CreateAsync(UserTypeDTO entity);
    }
}
