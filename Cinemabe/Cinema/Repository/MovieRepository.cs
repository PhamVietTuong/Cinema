using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

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
	}
}
