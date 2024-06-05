using System.Drawing.Printing;
using System.Linq;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Enum;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class TheaterRepository : ITheaterRepository
    {
        private readonly CinemaContext _context;

        public TheaterRepository(CinemaContext context)
        {
            _context = context;
        }

        public async Task<List<TheaterDTO>> GetAllTheater()
        {
            var theaters = await _context.Theater.Where(x => x.Status).ToListAsync();
            var result = new List<TheaterDTO>();

            foreach (var theater in theaters)
            {
                result.Add(new TheaterDTO
                {
                    Id = theater.Id,
                    Name = theater.Name,
                    Address = theater.Address,
                    Image = theater.Image,
                    Phone = theater.Phone,
                });
            }

            return result;
        }

        public async Task<List<MovieDetailViewModel>> GetShowTimeByTheaterId(Guid theaterId)
        {
            var showTimeRooms = await _context.ShowTimeRoom
            .Include(x => x.Room)
            .ThenInclude(x => x.Theater)
            .Include(x => x.ShowTime)
                .ThenInclude(x => x.Movie)
                    .ThenInclude(m => m.AgeRestriction)
            .Where(x => x.Room.TheaterId == theaterId && x.ShowTime.Status == true)
            .ToListAsync();

            var movies = showTimeRooms.Select(sRoom => sRoom.ShowTime.Movie).Distinct().ToList();

            var movieAndType = movies.Select(m => new
            {
                movie = m,
                types = _context.MovieTypeDetail
                    .Include(mtd => mtd.MovieType).Where(mtd => mtd.MovieId == m.Id).ToList(),
                showTimes = showTimeRooms
                    .Where(sRoom => sRoom.ShowTime.MovieId == m.Id)
                    .ToList()
            }).ToList();



            var rows = new List<MovieDetailViewModel>();
            foreach (var item in movieAndType)
            {
                void addMovie(int time, ProjectionForm form)
                {
                    rows.Add(new MovieDetailViewModel
                    {
                        Id = item.movie.Id,
                        AgeRestrictionName = item.movie.AgeRestriction.Name,
                        AgeRestrictionDescription = item.movie.AgeRestriction.Description,
                        AgeRestrictionAbbreviation = item.movie.AgeRestriction.Abbreviation,
                        Name = item.movie.Name,
                        Image = item.movie.Image,
                        Time = time,
                        ReleaseDate = item.movie.ReleaseDate,
                        Description = item.movie.Description,
                        Director = item.movie.Director,
                        Actor = item.movie.Actor,
                        Trailer = item.movie.Trailer,
                        Languages = item.movie.Languages,
                        MovieType = String.Join(", ", item.types.Select(type => type.MovieType.Name)),
                        ShowTimeTypeName = form == ProjectionForm.Time2D ? "2D" : "3D",
                        ProjectionForm = (int)form,
                        Schedules = item.showTimes
                            .Where(sRoom => sRoom.ShowTime.ProjectionForm == (int)form)
                            .GroupBy(sRoom => sRoom.ShowTime.StartTime.Date)
                            .Select(st => new ScheduleRowViewModel
                            {
                                Date = st.Key,
                                Theaters = st.GroupBy(x => new { x.Room.Theater.Name, x.Room.Theater.Address, x.Room.TheaterId })
                                .Select(x => new TheaterRowViewModel
                                {
                                    TheaterId = x.Key.TheaterId,
                                    TheaterAddress = x.Key.Address,
                                    TheaterName = x.Key.Name,
                                    ShowTimes = x.Select(showtime =>
                                     {
                                         bool isDulexe = _context.Seat.Include(x => x.SeatType).Where(x => x.RoomId == showtime.RoomId).Any(x => x.SeatType.Name == "Nằm");
                                         return new ShowTimeRowViewModel
                                         {
                                             RoomId = showtime.Room.Id,
                                             RoomName = showtime.Room.Name,
                                             ShowTimeId = showtime.ShowTime.Id,
                                             StartTime = showtime.ShowTime.StartTime,
                                             EndTime = showtime.ShowTime.EndTime,
                                             ShowTimeType = isDulexe ? ShowTimeType.Deluxe : ShowTimeType.Standard
                                         };
                                     }).ToList()

                                }).ToList(),
                            }).ToList()

                    });
                }
                if (item.movie.Time2D != -1)
                {
                    addMovie(item.movie.Time2D ?? 0, ProjectionForm.Time2D);
                }
                if (item.movie.Time3D != -1)
                {
                    addMovie(item.movie.Time3D ?? 0, ProjectionForm.Time3D);
                }

            }
            return rows;
        }

        public async Task<List<TheaterDTO>> GetTheatersByName(string name)
        {
            var input = name.Trim().ToLower().RemoveDiacritics();
            var theaters = await _context.Theater.Where(x => x.Status == true).Select(x => new TheaterDTO
            {
                Id = x.Id,
                Address = x.Address,
                Image = x.Image,
                Name = x.Name,
                Phone = x.Phone,
                Status = x.Status
            }).ToListAsync();
            var filteredTheaters = theaters.Where(x => x.Name.ToLower().RemoveDiacritics().Contains(input)).ToList();
            return filteredTheaters;
        }
    }
}
