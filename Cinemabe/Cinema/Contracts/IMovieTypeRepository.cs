using Cinema.DTOs;
using System.Linq.Expressions;

namespace Cinema.Contracts
{
    public interface IMovieTypeRepository
    {
        Task<List<MovieTypeDTO>> GetMovieTypeListAsync();
        Task<bool> ExistsAsync(Guid id);
        Task<MovieTypeDTO> UpdateAsync(MovieTypeDTO entity);
        Task<MovieTypeDTO> CreateAsync(MovieTypeDTO entity);
    }
}
