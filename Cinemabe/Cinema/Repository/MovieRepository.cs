using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;
using NuGet.DependencyResolver;
using System.Globalization;

namespace Cinema.Repository
{
	public class MovieRepository : IMovieRepository
	{
		private readonly CinemaContext _context;

		public MovieRepository(CinemaContext context)
		{
			_context = context;
		}

		public async Task<List<MovieViewModel>> GetMovieList()
		{
			var movieList = await _context.Movies.ToListAsync();

			var rows = new List<MovieViewModel>();
			foreach (Movie movie in movieList)
			{
				rows.Add(new MovieViewModel
				{
					Id = movie.Id,
					Name = movie.Name,
					Image = movie.Image,
					Time = movie.Time,
					ReleaseDate = movie.ReleaseDate,
					Description = movie.Description,
					Trailer = movie.Trailer,
				});
			}

			return rows;
		}

		public async Task<MovieDetailViewModel> GetMovieDetail(Guid id)
		{
			var movieDetail = await _context.Movies
											.Include(a => a.AgeRestriction)
											.Include(a => a.ShowTimeType)
											.FirstOrDefaultAsync(x => x.Id == id);

			if (movieDetail == null)
			{
				return null;
			}

			var movieTypeDetails = await _context.MovieTypeDetails
												.Include(x => x.MovieType)
												.Where(x => x.MovieId == movieDetail.Id)
												.ToListAsync();
			string movieTypes = String.Join(", ", movieTypeDetails.Select(x => x.MovieType.Name));

			var movieShowTimes = await _context.MovieShowTimes
												.Include(x => x.ShowTime)
													.ThenInclude(x => x.Theater)
												.Where(x => x.MovieId == movieDetail.Id).ToListAsync();
			var schedules = movieShowTimes
										.GroupBy(x => new { x.ShowTime.Day })
										.Select(schedule => new Schedules
										{
											Date = schedule.Key.Day,
											Theater = schedule
														.GroupBy(x => new { x.ShowTime.Theater.Name, x.ShowTime.Theater.Address })
														.Select(theater => new Theaters {
															TheaterName = theater.Key.Name,
															TheaterAddress = theater.Key.Address,
															ShowTime = theater.Select(showTime => new ShowTimes
															{
																StartTime = showTime.ShowTime.StartTime,
																EndTime = showTime.ShowTime.EndTime
															}).ToList()
														}).ToList()
										}).ToList();

			var viewModel = new MovieDetailViewModel
			{
				Id = movieDetail.Id,
				AgeRestrictionName = movieDetail.AgeRestriction.Name,
				AgeRestrictionDescription = movieDetail.AgeRestriction.Description,
				Name = movieDetail.Name,
				Image = movieDetail.Image,
				Time = movieDetail.Time,
				ReleaseDate = movieDetail.ReleaseDate,
				Description = movieDetail.Description,
				Director = movieDetail.Director,
				Actor = movieDetail.Actor,
				Trailer = movieDetail.Trailer,
				Languages = movieDetail.Languages,
				ShowTimeTypeName = movieDetail.ShowTimeType.Name,
				MovieType = movieTypes,
				Schedule = schedules
			};
			return viewModel;
		}
	}
}
