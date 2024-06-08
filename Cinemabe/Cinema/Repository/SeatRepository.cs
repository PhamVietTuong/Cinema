using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Enum;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class SeatRepository : ISeatRepository
    {
        private readonly CinemaContext _context;

        public SeatRepository(CinemaContext context)
        {
            _context = context;
        }

        public async Task<SeatViewModel> GetSeatByShowTimeAndRoomIdAysn(SeatByShowTimeAndRoomDTO vm)
        {
            var showTimeRoom = (await _context.ShowTimeRoom
                                .Include(x => x.ShowTime)
                                .Where(x => x.ShowTimeId == vm.ShowTimeId && x.RoomId == vm.RoomId)
                                .ToListAsync())
                                .FirstOrDefault();

            var seats = await _context.Seat
                                            .Include(x => x.SeatType)
                                            .Include(x => x.Room)
                                            .Where(x => x.RoomId == showTimeRoom.RoomId)
                                            .ToListAsync();

            var ticket = await _context.InvoiceTicket
                .Include(x => x.Seat)
                .Where(x => x.ShowTimeId == vm.ShowTimeId && x.Seat.RoomId == vm.RoomId).ToListAsync();

            var seatTypeTicketTypes = await _context.SeatTypeTicketType
                                            .Include(x => x.TicketType)
                                            .Include(x => x.SeatType)
                                            .ToListAsync();

            var roomName = seats.FirstOrDefault()?.Room.Name;

            var rowName = seats.GroupBy(x => new { x.RowName })
                                .Select(rowNameViewModel =>
                                {
                                    int colIndex = 1;
                                    var sortedSeats = rowNameViewModel.OrderBy(x => x.ColIndex).ToList();
                                    return new RowNameViewModel
                                    {
                                        RowName = rowNameViewModel.Key.RowName,
                                        RowSeats = sortedSeats.Select(rowSeatViewModel =>
                                        {
                                            var seatTypeTicketType = rowSeatViewModel.SeatTypeId.HasValue
                                                                                        ? seatTypeTicketTypes.FirstOrDefault(x => x.SeatTypeId == rowSeatViewModel.SeatTypeId.Value)
                                                                                        : null;
                                            string name = rowSeatViewModel.IsSeat ? $"{rowSeatViewModel.RowName}{colIndex}" : null;

                                            if (rowSeatViewModel.IsSeat)
                                            {
                                                colIndex++;
                                            }

                                            return new RowSeatViewModel
                                            {
                                                Id = rowSeatViewModel.Id,
                                                ColIndex = rowSeatViewModel.ColIndex,
                                                IsSeat = rowSeatViewModel.IsSeat,
                                                Name = name,
                                                SeatTypeId = rowSeatViewModel.SeatTypeId,
                                                SeatTypeName = rowSeatViewModel.SeatType?.Name,
                                                SeatStatus = ticket.Any(x => x.SeatId == rowSeatViewModel.Id) ? SeatStatus.Sold : SeatStatus.Empty,
                                            };
                                        }).OrderBy(x => x.ColIndex).ThenBy(x => x.Name)
                                        .ToList()
                                    };
                                }).OrderBy(x => x.RowName).ToList();

            var result = new SeatViewModel
            {
                RoomName = roomName,
                RowName = rowName
            };
            return result;
        }
    }
}
