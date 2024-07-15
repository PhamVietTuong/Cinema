using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface INewsRepository
    {
        Task<List<NewsDTO>> GetNewsListAsync();
    }
}
