using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface ITheaterRepository
    {
        Task<List<TheaterDTO>> GetAllTheater();
        Task<List<MovieDetailViewModel>> GetShowTimeByTheaterId(Guid theaterId);
		Task<List<TheaterDTO>> GetTheatersByName(string name);
		Task<TheaterDTO> GetTheaterAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
        Task<List<TheaterDTO>> GetTheaterListAsync();
        Task<TheaterDTO> UpdateAsync(TheaterDTO entity);
        Task<TheaterDTO> CreateAsync(TheaterDTO entity);
    }
}
