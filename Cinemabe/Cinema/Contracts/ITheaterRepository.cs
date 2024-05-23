using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface ITheaterRepository
    {
        Task<List<TheaterDTO>> GetAllTheater();
        Task<List<ShowTimeDTO>> GetShowTimeByDateAndTheaterId(ShowTimeByDateAndTheaterId showTimeByDateAndTheaterId);
    }
}
