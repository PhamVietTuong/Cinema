using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface IMovieRepository
	{
		Task<List<MovieDetailViewModel>> GetMovieList();
		Task<MovieDetailViewModel> GetMovieDetail(MovieDetailDTO movieDetailDTO);
		Task<List<MovieDetailViewModel>> GetMovieTheaterId(Guid theaterId);
		 Task<List<MovieDetailViewModel>> GetMoviesByName(string name);

	}
}
