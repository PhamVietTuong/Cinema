using AutoMapper;
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
        private readonly IMapper _mapper;
        private readonly CinemaContext _context;

        public MovieRepository(CinemaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }


        public async Task<List<MovieDTO>> GetMoviesOriginal()
        {
            var m = await _context.Movie.Include(x => x.AgeRestriction).ToListAsync();
            var result = m.Select(x => _mapper.Map<MovieDTO>(x)).ToList();
            foreach (var movie in result)
            {
                var movieTypeDetails = await _context.MovieTypeDetail.Include(d => d.MovieType).Where(x => x.MovieId == movie.Id).Select(x => x.MovieType).ToListAsync();
                movie.MovieTypes = _mapper.Map<List<MovieTypeDTO>>(movieTypeDetails);
            }
            return result;
        }

        public async Task<MovieDTO> GetMovieById(Guid id)
        {
            var m = await _context.Movie.Include(x => x.AgeRestriction).FirstOrDefaultAsync(x => x.Id == id);
            var r = _mapper.Map<MovieDTO>(m);
            r.MovieTypes = await _context.MovieTypeDetail
                    .Include(x => x.MovieType)
                    .Where(x => x.MovieId == r.Id)
                    .Select(x => _mapper.Map<MovieTypeDTO>(x.MovieType))
                    .ToListAsync();
            var resultShowTimeRooms = new List<ShowTimeRoomDTO>();

            var showTimeRooms = await _context.ShowTimeRoom.Include(x => x.ShowTime).Include(x => x.Room).ThenInclude(x => x.Theater).Where(x => x.ShowTime.MovieId == id).ToListAsync();

            foreach (var showTimeRoom in showTimeRooms)
            {
                resultShowTimeRooms.Add(new ShowTimeRoomDTO
                {
                    ShowTimeId = showTimeRoom.ShowTimeId,
                    RoomId = showTimeRoom.RoomId,
                    StartTime = showTimeRoom.ShowTime.StartTime,
                    EndTime = showTimeRoom.ShowTime.EndTime,
                    RoomName = showTimeRoom.Room.Name,
                    ProjectionForm = showTimeRoom.ShowTime.ProjectionForm,
                    TheaterName = showTimeRoom.Room.Theater.Name,
                });
            }
            r.ShowTimeRooms = resultShowTimeRooms;
            return r;
        }

        public async Task<MovieDTO> CreateMovie(MovieDTO movie)
        {
            var m = _mapper.Map<Movie>(movie);
            if (movie.File != null && movie.File.Length > 0)
            {
                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(movie.File.FileName);
                var filePath = Path.Combine("wwwroot/images", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await movie.File.CopyToAsync(stream);
                }
                m.Image = fileName;
            }

            _context.Movie.Add(m);
            await _context.SaveChangesAsync();

            foreach (var movieType in movie.MovieTypes)
            {
                _context.MovieTypeDetail.Add(new MovieTypeDetail
                {
                    MovieId = m.Id,
                    MovieTypeId = movieType.Id
                });
            }
            await _context.SaveChangesAsync();
            return movie;
        }

        public async Task<List<MovieDetailViewModel>> GetMovieList()
        {
            var movieList = await _context.Movie.Include(x => x.AgeRestriction).OrderBy(x => x.ReleaseDate).Where(x => x.Status).ToListAsync();

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
                                                            }).OrderBy(x => x.StartTime).ToList()
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

            var showtimeViewModels = showTimeRoom.Select(sr =>
            {
                bool isDulexe = _context.Seat.Include(x => x.SeatType).Where(x => x.RoomId == sr.RoomId).Any(x => x.SeatType.Name == "Nằm");

                return new ShowTimeRowViewModel
                {
                    ShowTimeId = sr.ShowTime.Id,
                    StartTime = sr.ShowTime.StartTime,
                    EndTime = sr.ShowTime.EndTime,
                    RoomId = sr.Room.Id,
                    RoomName = sr.Room.Name,
                    ShowTimeType = isDulexe ? ShowTimeType.Deluxe : ShowTimeType.Standard
                };
            }).ToList();

            return showtimeViewModels;
        }

        public async Task<List<MovieDetailViewModel>> GetMoviesByName(SearchDTO search)
        {
            var input = search.SearchKey.Trim().ToLower().RemoveDiacritics();
            var movies = await _context.Movie
                               .Include(x => x.AgeRestriction)
                               .Where(x => x.Status == true)
                               .ToListAsync();

            var filteredMovies = search.IsActor
            ? movies.Where(x => x.Actor.ToLower().RemoveDiacritics().Contains(input)).ToList()
            : movies.Where(x => x.Name.ToLower().RemoveDiacritics().Contains(input)).ToList();
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

        public async Task<MovieDTO> UpdateAsync(MovieDTO entity)
        {
            var movie = await _context.Movie.FirstOrDefaultAsync(x => x.Id == entity.Id);

            movie.Actor = entity.Actor;
            movie.Name = entity.Name;
            movie.Director = entity.Director;
            movie.AgeRestrictionId = entity.AgeRestrictionId;
            movie.Description = entity.Description;
            movie.Image = entity.Image;
            movie.Languages = entity.Languages;
            movie.ReleaseDate = entity.ReleaseDate;
            movie.Time2D = entity.Time2D;
            movie.Time3D = entity.Time3D;
            movie.Trailer = entity.Trailer;
            movie.Status = entity.Status;

            var movieTypeDetails = await _context.MovieTypeDetail.Where(x => x.MovieId == entity.Id).ToListAsync();

            foreach (var movieTypeDetail in movieTypeDetails)
            {
                if (!entity.MovieTypes.Select(x => x.Id).Contains(movieTypeDetail.MovieTypeId))
                {
                    _context.MovieTypeDetail.Remove(movieTypeDetail);
                }
            }

            foreach (var movieType in entity.MovieTypes)
            {
                if (!movieTypeDetails.Any(x => x.MovieTypeId == movieType.Id))
                {
                    _context.MovieTypeDetail.Add(new MovieTypeDetail
                    {
                        MovieId = entity.Id,
                        MovieTypeId = movieType.Id
                    });
                }
            }

            await _context.SaveChangesAsync();

            return entity;
        }

        public async Task<List<CommentViewModel>> GetCommentsByMovieID(Guid movieId)
        {
            var comments = await _context.Comment
       .Include(x => x.User)
       .Where(x => x.MovieId == movieId && x.ParentId == null)
       .Select(x => new CommentViewModel
       {
           Id = x.Id,
           Content = x.Content,
           UserName = x.User.FullName,
           CreatedDate = x.CreatedDate,
           Replies = x.Replies.Select(y => new CommentViewModel
           {
               Id = y.Id,
               Content = y.Content,
               UserName = y.User.FullName,
               CreatedDate = y.CreatedDate,
               Replies = new List<CommentViewModel>() // Initialize Replies as an empty list
           }).ToList()
       }).ToListAsync();

            return comments;
        }
    }

}
