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
                    Status = theater.Status,
                });
            }

            return result;
        }

        public async Task<List<MovieDetailViewModel>> GetShowTimeByTheaterId(Guid theaterId)
        {
            var showTimeRooms = await _context.ShowTimeRoom
            .Include(x => x.Room)
            .Include(x => x.ShowTime)
                .ThenInclude(x => x.Movie)
                    .ThenInclude(m => m.AgeRestriction)
            .Where(x => x.Room.TheaterId == theaterId)
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
                        Schedules = item.showTimes
                            .Where(sRoom => sRoom.ShowTime.ProjectionForm == (int)form)
                            .GroupBy(sRoom => sRoom.ShowTime.StartTime.Date)
                            .Select(st => new ScheduleRowViewModel
                            {
                                Date = st.Key,
                                Showtimes = st.Select(x => new ShowTimeRowViewModel
                                {
                                    RoomId = x.RoomId,
                                    RoomName = x.Room.Name,
                                    ShowTimeId = x.ShowTime.Id,
                                    StartTime = x.ShowTime.StartTime,
                                    EndTime = x.ShowTime.EndTime,
                                }).ToList()
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



    }
}
