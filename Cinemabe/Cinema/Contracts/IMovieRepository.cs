using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface IMovieRepository
	{
		Task<List<MovieViewModel>> GetMovieList();
		Task<MovieDetailViewModel> GetMovieDetail(Guid id);
	}
}
