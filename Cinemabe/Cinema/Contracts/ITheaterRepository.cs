using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface ITheaterRepository
    {
        Task<List<TheaterDTO>> GetAllTheater();
        Task<List<MovieDetailViewModel>> GetShowTimeByTheaterId(Guid theaterId);
    }
}
