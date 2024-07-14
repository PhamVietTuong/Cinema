using AutoMapper;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class ShowTimeRoomRepository : IShowTimeRoomRepository
    {
        private readonly CinemaContext _context;

        public ShowTimeRoomRepository(CinemaContext context)
        {
            _context = context;
        }

        public async Task<ShowTimeRoomDTO> UpdateAsync(ShowTimeRoomDTO entity)
        {
            var showTime = await _context.ShowTime.FirstOrDefaultAsync(x => x.Id == entity.ShowTimeId);

            if (showTime == null)
            {
                showTime = new ShowTime
                {
                    Id = Guid.NewGuid(),
                    MovieId = entity.MovieId,
                    StartTime = entity.StartTime,
                    EndTime = entity.EndTime,
                    ProjectionForm = entity.ProjectionForm,
                    Status = true
                };
                _context.ShowTime.Add(showTime);
            }
            else
            {
                showTime.StartTime = entity.StartTime;
                showTime.EndTime = entity.EndTime;
                showTime.ProjectionForm = entity.ProjectionForm;
            }

            var showTimeRoomEntry = await _context.ShowTimeRoom.FirstOrDefaultAsync(x => x.ShowTimeId == showTime.Id && x.RoomId == entity.RoomId);
            if (showTimeRoomEntry == null)
            {
                _context.ShowTimeRoom.Add(new ShowTimeRoom
                {
                    ShowTimeId = showTime.Id,
                    RoomId = entity.RoomId
                });
            }

            await _context.SaveChangesAsync();

            return entity;
        }
    }
}
