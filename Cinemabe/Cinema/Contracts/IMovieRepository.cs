using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface IMovieRepository
	{
		Task<List<MovieDetailViewModel>> GetMovieList();
		Task<MovieDetailViewModel> GetMovieDetail(MovieDetailDTO movieDetailDTO);
	}
}
