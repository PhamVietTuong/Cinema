using Cinema.DTOs;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

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
