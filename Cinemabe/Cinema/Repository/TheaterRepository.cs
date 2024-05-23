using Cinema.Contracts;
using Cinema.Data;
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

            foreach(var theater in theaters)
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

        public async Task<List<ShowTimeDTO>> GetShowTimeByDateAndTheaterId(ShowTimeByDateAndTheaterId showTimeByDateAndTheaterId)
        {
            var showTimeRooms = await _context.ShowTimeRoom
                                                .Include(x => x.Room)
                                                .Include(x => x.ShowTime)
                                                    .ThenInclude(x => x.Movie)
                                                .Where(x => x.Room.TheaterId == showTimeByDateAndTheaterId.TheaterId && x.ShowTime.StartTime.Date == showTimeByDateAndTheaterId.Date).ToListAsync();

            var result = new List<ShowTimeDTO>();

            foreach (var showTimeRoom in showTimeRooms)
            {
                result.Add(new ShowTimeDTO
                {
                    Id = showTimeRoom.ShowTimeId,
                    MovieId = showTimeRoom.ShowTime.MovieId,
                    MovieName = showTimeRoom.ShowTime.Movie.Name,
                    StartTime = showTimeRoom.ShowTime.StartTime,
                    EndTime = showTimeRoom.ShowTime.EndTime,
                    ProjectionForm = showTimeRoom.ShowTime.ProjectionForm,
                });
            }

            return result;
        }
    }
}
