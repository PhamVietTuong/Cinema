using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface IShowTimeRoomRepository
    {
        Task<ShowTimeRoomDTO> UpdateAsync(ShowTimeRoomDTO entity);
    }
}
