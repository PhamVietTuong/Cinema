using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Enum;
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

        public async Task<List<MovieDetailViewModel>> GetMovieList()
        {
            var movieList = await _context.Movie.Include(x => x.AgeRestriction).ToListAsync();

            var rows = new List<MovieDetailViewModel>();
            foreach (var movie in movieList)
            {
                var movieTypeDetails = await _context.MovieTypeDetail
                    .Include(x => x.MovieType)
                    .Where(x => x.MovieId == movie.Id)
                    .ToListAsync();

                string movieTypes = String.Join(", ", movieTypeDetails.Select(x => x.MovieType.Name));

                if (movie.Time2D != -1)
                {
                    rows.Add(new MovieDetailViewModel
                    {
                        Id = movie.Id,
                        AgeRestrictionName = movie.AgeRestriction.Name,
                        AgeRestrictionAbbreviation = movie.AgeRestriction.Abbreviation,
                        AgeRestrictionDescription = movie.AgeRestriction.Description,
                        Name = movie.Name,
                        Image = movie.Image,
                        Time = movie.Time2D,
                        ReleaseDate = movie.ReleaseDate,
                        Description = movie.Description,
                        Director = movie.Director,
                        Actor = movie.Actor,
                        Trailer = movie.Trailer,
                        Languages = movie.Languages,
                        MovieType = movieTypes,
                        ProjectionForm = (int)ProjectionForm.Time2D,
                        ShowTimeTypeName = "2D",
                    });
                }

                if (movie.Time3D != -1)
                {
                    rows.Add(new MovieDetailViewModel
                    {
                        Id = movie.Id,
                        AgeRestrictionName = movie.AgeRestriction.Name,
                        AgeRestrictionAbbreviation = movie.AgeRestriction.Abbreviation,
                        AgeRestrictionDescription = movie.AgeRestriction.Description,
                        Name = movie.Name,
                        Image = movie.Image,
                        Time = movie.Time3D,
                        ReleaseDate = movie.ReleaseDate,
                        Description = movie.Description,
                        Director = movie.Director,
                        Actor = movie.Actor,
                        Trailer = movie.Trailer,
                        Languages = movie.Languages,
                        MovieType = movieTypes,
                        ProjectionForm = (int)ProjectionForm.Time3D,
                        ShowTimeTypeName = "3D",
                    });
                }
            }

            return rows;
        }

        public async Task<MovieDetailViewModel> GetMovieDetail(MovieDetailDTO movieDetailDTO)
        {

            var movieDetail = await _context.Movie
                                .Include(x => x.AgeRestriction)
                                .FirstOrDefaultAsync(x => x.Id == movieDetailDTO.Id);

            if (movieDetail == null)
            {
                return null;
            }

            int? selectedTime = movieDetailDTO.ProjectionForm == ProjectionForm.Time2D
                                ? movieDetail.Time2D
                                : movieDetailDTO.ProjectionForm == ProjectionForm.Time3D
                                  ? movieDetail.Time3D
                                  : null;

            if (selectedTime == -1 || selectedTime == null)
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
                                                        .Where(x => x.ShowTime.MovieId == movieDetail.Id && x.ShowTime.ProjectionForm == movieDetailDTO.ProjectionForm)
                                                        .ToListAsync();

            var schedules = showTimeRoom
                                        .GroupBy(x => x.ShowTime.StartTime.Date)
                                        .Select(schedule => new ScheduleRowViewModel
                                        {
                                            Date = schedule.Key,
                                            Theaters = schedule
                                                        .GroupBy(x => new { x.Room.Theater.Name, x.Room.Theater.Address, x.Room.TheaterId })
                                                        .Select(theater => new TheaterRowViewModel
                                                        {
                                                            TheaterName = theater.Key.Name,
                                                            TheaterAddress = theater.Key.Address,
                                                            TheaterId = theater.Key.TheaterId,

                                                            ShowTimes = theater.Select(showTime =>
                                                            {
                                                                bool isDulexe = _context.Seat.Include(x => x.SeatType).Where(x => x.RoomId == showTime.RoomId).Any(x => x.SeatType.Name == "Nằm");
                                                                return new ShowTimeRowViewModel
                                                                {
                                                                    RoomId = showTime.Room.Id,
                                                                    RoomName = showTime.Room.Name,
                                                                    ShowTimeId = showTime.ShowTime.Id,
                                                                    StartTime = showTime.ShowTime.StartTime,
                                                                    EndTime = showTime.ShowTime.EndTime,
                                                                    ShowTimeType = isDulexe ? ShowTimeType.Deluxe : ShowTimeType.Standard
                                                                };
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
                Time = (int)(movieDetailDTO.ProjectionForm == ProjectionForm.Time2D ? movieDetail.Time2D : movieDetail.Time3D),
                ReleaseDate = movieDetail.ReleaseDate,
                Description = movieDetail.Description,
                Director = movieDetail.Director,
                Actor = movieDetail.Actor,
                Trailer = movieDetail.Trailer,
                Languages = movieDetail.Languages,
                ShowTimeTypeName = movieDetailDTO.ProjectionForm == ProjectionForm.Time2D ? "2D" : "3D",
                MovieType = movieTypes,
                ProjectionForm = movieDetailDTO.ProjectionForm == ProjectionForm.Time2D ? 0 : 1,
                Schedules = schedules
            };
            return viewModel;
        }

        public async Task<List<MovieDetailViewModel>> GetMovieTheaterId(Guid theaterId)
        {
            var showTimeRooms = await _context.ShowTimeRoom
            .Include(x => x.Room)
            .Include(x => x.ShowTime)
                .ThenInclude(x => x.Movie)
                    .ThenInclude(m => m.AgeRestriction)
            .Where(x => x.Room.TheaterId == theaterId)
            .ToListAsync();

            var movies = showTimeRooms.Select(sRoom => sRoom.ShowTime.Movie).Distinct().ToList();

            var rows = new List<MovieDetailViewModel>();
            foreach (var movie in movies)
            {
                if (movie.Time2D != -1)
                {
                    rows.Add(new MovieDetailViewModel
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
                        AgeRestrictionAbbreviation = movie.AgeRestriction.Abbreviation,
                        ShowTimeTypeName = "2D",

                    });
                }

                if (movie.Time3D != -1)
                {
                    rows.Add(new MovieDetailViewModel
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
                        AgeRestrictionAbbreviation = movie.AgeRestriction.Abbreviation,
                        ShowTimeTypeName = "3D",
                    });
                }
            }
            return rows;
        }

        public async Task<List<DateTime>> GetDateByMovieID(Guid movieID, ProjectionForm ProjectionForm)
        {
            var days = await _context.ShowTime
                .Where(x => x.MovieId == movieID && x.ProjectionForm == ProjectionForm)
                .Select(x => x.StartTime.Date)
                .Distinct()
                .ToListAsync();

            return days;
        }

        public async Task<List<ShowTimeRowViewModel>> GetShowTimeByMovieID(Guid movieID, DateTime date, ProjectionForm ProjectionForm)
        {
            var showTimeRoom = await _context.ShowTimeRoom
                .Include(sr => sr.ShowTime)
                    .ThenInclude(st => st.Movie)
                .Include(sr => sr.Room)
                .Where(sr => sr.ShowTime.MovieId == movieID && sr.ShowTime.StartTime.Date == date.Date && sr.ShowTime.ProjectionForm == ProjectionForm)
                .ToListAsync();

            var showtimeViewModels = showTimeRoom.Select(sr => new ShowTimeRowViewModel
            {
                ShowTimeId = sr.ShowTime.Id,
                StartTime = sr.ShowTime.StartTime,
                EndTime = sr.ShowTime.EndTime,
                RoomId = sr.Room.Id,
                RoomName = sr.Room.Name,

            }).ToList();

            return showtimeViewModels;
        }

        public async Task<List<MovieDetailViewModel>> GetMoviesByName(string name)
        {
            var input = name.Trim().ToLower().RemoveDiacritics();
            var movies = await _context.Movie
                               .Include(x => x.AgeRestriction)
                               .Where(x => x.Status == true)
                               .ToListAsync();
            var filteredMovies = movies.Where(x => x.Name.ToLower().RemoveDiacritics().Contains(input)).ToList();
            var results = new List<MovieDetailViewModel>();
            foreach (var movie in filteredMovies)
            {
                void addMovie(int time, ProjectionForm form)
                {
                    results.Add(new MovieDetailViewModel
                    {
                        Id = movie.Id,
                        AgeRestrictionName = movie.AgeRestriction.Name,
                        AgeRestrictionDescription = movie.AgeRestriction.Description,
                        AgeRestrictionAbbreviation = movie.AgeRestriction.Abbreviation,
                        Name = movie.Name,
                        Image = movie.Image,
                        Time = time,
                        ReleaseDate = movie.ReleaseDate,
                        Description = movie.Description,
                        Director = movie.Director,
                        Actor = movie.Actor,
                        Trailer = movie.Trailer,
                        Languages = movie.Languages,
                        MovieType = String.Join(", ", _context.MovieTypeDetail.Include(x => x.MovieType).Where(x => x.MovieId == movie.Id).Select(x => x.MovieType.Name).ToList()),
                        ShowTimeTypeName = form == ProjectionForm.Time2D ? "2D" : "3D",
                        ProjectionForm = (int)form

                    });
                }
                if (movie.Time2D != -1)
                {
                    addMovie(movie.Time2D ?? 0, ProjectionForm.Time2D);
                }
                if (movie.Time3D != -1)
                {
                    addMovie(movie.Time3D ?? 0, ProjectionForm.Time3D);
                }
            }
            return results;
        }
    }
}
