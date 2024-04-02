using Cinema.Contracts;
using Cinema.Data;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
	public class ShowTimeRepository : IShowTimeRepository
	{
		private readonly CinemaContext _context;

        public ShowTimeRepository(CinemaContext context)
        {
            _context = context;
        }

		public async Task<bool> Exit(int id)
		{
			return await _context.ShowTimes.AnyAsync(e => e.Id == id);
		}

		public async Task<InformationAboutBoxOfficeViewModel> GetInformationAboutBoxOffice(int showTimeId)
		{
			var showtime = await _context.ShowTimes
				.Include(a => a.Movie)
					.ThenInclude(a => a.AgeRestriction)
				.Include(a => a.Theater)
				.Include(a => a.ShowTimeType)
				.Include(a => a.Room)
				.FirstOrDefaultAsync(a => a.Id == showTimeId);
			var chair = await _context.Chairs
				.Include(c => c.ChairType)
				.Include(c => c.RowChair)
				.Where(c => c.RoomId == showtime.RoomId).ToListAsync();

			var moviesInformation = new MoviesInformation
			{
				AgeRestrictionName = showtime.Movie.AgeRestriction?.Name,
				Name = showtime.Movie.Name,
				Image = showtime.Movie.Image,
				Time = showtime.Movie.Time,
				ReleaseDate = showtime.Movie.ReleaseDate,
				Description = showtime.Movie.Description,
				Director = showtime.Movie.Director,
				Actor = showtime.Movie.Actor,
				Trailer = showtime.Movie.Trailer,
				Languages = showtime.Movie.Languages
			};

			var listChair = chair.Select(c => new ListChair
			{
				ChairTypeName = c.ChairType.Name,
				RowChairName = c.RowChair.Name,
				Name = c.Name,
				Price = c.ChairType.Price,
				IsSold = c.IsSold,

			}).ToList();

			var informatiionAboutBoxOffice = new InformationAboutBoxOfficeViewModel
			{
				Id = showtime.Id,
				TheaterName = showtime.Theater.Name,
				TheaterAddress = showtime.Theater.Address,
				ShowTimeTypeName = showtime.ShowTimeType.Name,
				Day = showtime.Day,
				StartTime = showtime.StartTime,
				EndTime = showtime.EndTime,
				MoviesInformation = moviesInformation,
				ListChair = listChair,
			};
			return informatiionAboutBoxOffice;
		}
	}
}
