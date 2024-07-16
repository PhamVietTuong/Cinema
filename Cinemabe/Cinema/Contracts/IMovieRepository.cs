using Cinema.Data.Enum;
using Cinema.Data.Models;
using Cinema.DTOs;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Cinema.Contracts
{
	public interface IMovieRepository
	{
		Task<List<MovieDTO>> GetMoviesOriginal();
		Task<MovieDTO> CreateMovie(MovieDTO Movie);
		Task<MovieDTO> GetMovieById(Guid id);
		Task<List<MovieDetailViewModel>> GetMovieList();
		Task<MovieDetailViewModel> GetMovieDetail(MovieDetailDTO movieDetailDTO);
		Task<List<MovieDetailViewModel>> GetMovieTheaterId(Guid theaterId);
		Task<List<MovieDetailViewModel>> GetMoviesByName(SearchDTO searchDTO);
		Task<List<DateTime>> GetDateByMovieID(Guid movieID, ProjectionForm ProjectionForm);
		Task<List<ShowTimeRowViewModel>> GetShowTimeByMovieID(Guid movieID, DateTime date, ProjectionForm ProjectionForm);
		Task<List<CommentViewModel>> GetCommentsByMovieID(Guid movieID);
		Task<MovieDTO> UpdateAsync(MovieDTO entity);
	}
}
