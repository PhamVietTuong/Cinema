using System.Drawing.Printing;
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

        //24/05/2024 tienn changed method
        public async Task<List<ShowtimeRoomDTO>> GetShowTimeByDateAndTheaterId(ShowTimeByDateAndTheaterId showTimeByDateAndTheaterId)
        {
            var showTimeRooms = await _context.ShowTimeRoom
            .Include(x => x.Room)
            .Include(x => x.ShowTime)
                .ThenInclude(x => x.Movie)
                    .ThenInclude(m => m.AgeRestriction)
            .Where(x => x.Room.TheaterId == showTimeByDateAndTheaterId.TheaterId &&
                     x.ShowTime.StartTime.Date == showTimeByDateAndTheaterId.Date.Date)
            .Select(x => new
            {
                ShowTime = x.ShowTime,
                Room = x.Room,
                SeatTypeIds = _context.Seat
                    .Where(s => s.RoomId == x.Room.Id && s.SeatTypeId.HasValue)
                    .Select(s => s.SeatTypeId.Value)
                    .Distinct()
                    .ToList()
            })
            .ToListAsync();

            var result = showTimeRooms.Select(x => new ShowtimeRoomDTO
            {
                ShowTime = x.ShowTime,
                Room = x.Room,
                SeatTypeTicketTypes = _context.SeatTypeTicketType
                                                    .Include(y => y.SeatType)
                                                    .Include(y => y.TicketType)
                                                    .Where(y => x.SeatTypeIds.Contains(y.SeatTypeId))
                                                    .ToList(),
                MovieTypes = _context.MovieTypeDetail
                    .Include(mt => mt.MovieType)
                    .Where(mt => mt.MovieId == x.ShowTime.Movie.Id)
                    .Select(mt => new MovieType
                    {
                        Id = mt.MovieTypeId,
                        Name = mt.MovieType.Name
                    })
                    .ToList()
            }).ToList();

            return result;
        }



    }
}
