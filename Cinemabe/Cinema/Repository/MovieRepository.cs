using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Enum;
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
			var movieList = await _context.Movie.Include(x => x.AgeRestriction).ToListAsync();

			var rows = new List<MovieViewModel>();
			foreach (var movie in movieList)
			{
				if (movie.Time2D != -1)
				{
                    rows.Add(new MovieViewModel
                    {
                        Id = movie.Id,
                        Name = movie.Name,
                        Image = movie.Image,
                        Time = movie.Time2D,
                        ReleaseDate = movie.ReleaseDate,
                        Description = movie.Description,
                        Trailer = movie.Trailer,
                        ProjectionForm = (int)ProjectionForm.Time2D,
                        AgeRestrictionName = movie.AgeRestriction.Name,
                        AgeRestrictionAbbreviation = movie.AgeRestriction.Abbreviation
                    });
                }

                if (movie.Time3D != -1)
                {
                    rows.Add(new MovieViewModel
                    {
                        Id = movie.Id,
                        Name = movie.Name,
                        Image = movie.Image,
                        Time = movie.Time3D,
                        ReleaseDate = movie.ReleaseDate,
                        Description = movie.Description,
                        Trailer = movie.Trailer,
                        ProjectionForm = (int)ProjectionForm.Time3D,
                        AgeRestrictionName = movie.AgeRestriction.Name,
                        AgeRestrictionAbbreviation = movie.AgeRestriction.Abbreviation
                    });
                }
            }

			return rows;
		}

		public async Task<MovieDetailViewModel> GetMovieDetail(MovieDetailDTO movieDetailDTO)
		{
			var movieDetail = await _context.Movie
											.Include(a => a.AgeRestriction)
											.FirstOrDefaultAsync(x => x.Id == movieDetailDTO.Id);

			if (movieDetail == null)
			{
				return null;
			}

			var movieTypeDetails = await _context.MovieTypeDetail
												.Include(x => x.MovieType)
												.Where(x => x.MovieId == movieDetail.Id)
												.ToListAsync();

			string movieTypes = String.Join(", ", movieTypeDetails.Select(x => x.MovieType.Name));

			var showTimeRoom = await _context.ShowTimeRoom
														.Include(x => x.ShowTime)
														.Include(x => x.Room)
															.ThenInclude(x => x.Theater)
														.Where(x => x.ShowTime.MovieId == movieDetail.Id)
														.ToListAsync();

			var schedules = showTimeRoom
                                        .GroupBy(x => x.ShowTime.StartTime.Date )
										.Select(schedule => new ScheduleRowViewModel
										{
                                            Date = schedule.Key,
                                            Theaters = schedule
														.GroupBy(x => new { x.Room.Theater.Name, x.Room.Theater.Address })
														.Select(theater => new TheaterRowViewModel
														{
															TheaterName = theater.Key.Name,
															TheaterAddress = theater.Key.Address,
															ShowTimes = theater.Select(showTime => new ShowTimeRowViewModel
                                                            {
                                                                RoomId = showTime.Room.Id,
                                                                RoomName = showTime.Room.Name,
																ShowTimeId = showTime.ShowTime.Id,
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
                AgeRestrictionAbbreviation = movieDetail.AgeRestriction.Abbreviation,
                Name = movieDetail.Name,
				Image = movieDetail.Image,
				Time = (int)(movieDetailDTO.ProjectionForm == (int)ProjectionForm.Time2D ? movieDetail.Time2D : movieDetail.Time3D),
                ReleaseDate = movieDetail.ReleaseDate,
				Description = movieDetail.Description,
				Director = movieDetail.Director,
				Actor = movieDetail.Actor,
				Trailer = movieDetail.Trailer,
				Languages = movieDetail.Languages,
				ShowTimeTypeName = movieDetailDTO.ProjectionForm == (int)ProjectionForm.Time2D ? "2D" : "3D",
				MovieType = movieTypes,
				Schedules = schedules
			};
			return viewModel;
		}
	}
}
