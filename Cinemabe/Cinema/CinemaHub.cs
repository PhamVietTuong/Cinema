using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Linq;

namespace Cinema
{
    public class CinemaHub : Hub
    {
        private readonly IDictionary<string, TicketBookingSuccess> _seatBeingSelected;
        private readonly CinemaContext _context;

        public CinemaHub(IDictionary<string, TicketBookingSuccess> seatBeingSelected, CinemaContext context)
        {
            _seatBeingSelected = seatBeingSelected;
            _context = context;
        }

        private string GetGroupKey(Guid showTimeId, Guid roomId)
        {
            return $"{showTimeId}-{roomId}";
        }

        public override Task OnDisconnectedAsync(Exception exception)
        {
            if (_seatBeingSelected.TryGetValue(Context.ConnectionId, out TicketBookingSuccess entity))
            {
                _seatBeingSelected.Remove(Context.ConnectionId);
                Clients.Group(GetGroupKey(entity.ShowTimeId, entity.RoomId)).SendAsync("UpdateSeat", entity.SeatIds.ToList(), SeatStatus.Empty);
            }

            return base.OnDisconnectedAsync(exception);
        }

        public async Task SeatBeingSelected(TicketBookingSuccess entity)
        {
            var selfSeatIds = _seatBeingSelected[Context.ConnectionId].SeatIds;
            var allSeatIdsExceptSelf = _seatBeingSelected.Values
                .Where(x => x.ShowTimeId == entity.ShowTimeId && x.RoomId == entity.RoomId)
                .SelectMany(x => x.SeatIds)
                .Except(selfSeatIds)
                .ToList();

            foreach (var seatId in allSeatIdsExceptSelf)
            {
                if (entity.SeatIds.Contains(seatId))
                {
                    await Clients.Caller.SendAsync("CheckForEmptySeats", seatId, SeatStatus.Waiting);
                    return;
                }
            }

            var ticket = await _context.Ticket
                                    .Include(x => x.Seat)
                                    .Where(x => x.ShowTimeId == entity.ShowTimeId && x.Seat.RoomId == entity.RoomId && entity.SeatIds.Contains(x.SeatId))
                                    .ToListAsync();

            if (ticket.Any())
            {
                await Clients.Caller.SendAsync("CheckForEmptySeats", ticket.Select(x => x.SeatId).Distinct(), SeatStatus.Sold);
                return;
            }

            if (!_seatBeingSelected.ContainsKey(Context.ConnectionId))
            {
                _seatBeingSelected[Context.ConnectionId] = entity;

            }

            if (_seatBeingSelected.ContainsKey(Context.ConnectionId))
            {
                var seatIds = _seatBeingSelected[Context.ConnectionId].SeatIds;
                var seatsToRemove = new List<Guid>();

                foreach (var seatId in seatIds)
                {
                    if (!entity.SeatIds.Contains(seatId))
                    {
                        seatsToRemove.Add(seatId);
                    }
                }

                foreach (var seatIdToRemove in seatsToRemove)
                {
                    seatIds.Remove(seatIdToRemove);
                }

                var seatsToAdd = new List<Guid>();

                foreach (var seatId in entity.SeatIds)
                {
                    if (!seatIds.Any(x => x == seatId))
                    {
                        seatIds.Add(seatId);
                        seatsToAdd.Add(seatId);
                    };
                }

                if (seatsToAdd.Any())
                {
                    await Clients.OthersInGroup(GetGroupKey(entity.ShowTimeId, entity.RoomId)).SendAsync("UpdateSeat", seatsToAdd.ToList(), SeatStatus.Waiting);
                }

                if (seatsToRemove.Any())
                {
                    await Clients.OthersInGroup(GetGroupKey(entity.ShowTimeId, entity.RoomId)).SendAsync("UpdateSeat", seatsToRemove.ToList(), SeatStatus.Empty);
                }
            }
        }

        public async Task JoinShowTime(TicketBookingSuccess entity)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, (GetGroupKey(entity.ShowTimeId, entity.RoomId)));

            _seatBeingSelected[Context.ConnectionId] = entity;

            await GetWaitingSeat(entity.ShowTimeId, entity.RoomId);
        }

        public async Task CheckTheSeatBeforeBooking(TicketBookingSuccess entity)
        {
            var tickets = await _context.Ticket
                                    .Include(x => x.Seat)
                                    .Where(x => x.ShowTimeId == entity.ShowTimeId && x.Seat.RoomId == entity.RoomId && entity.SeatIds.Contains(x.SeatId))
                                    .ToListAsync();

            var uniqueTickets = tickets
                    .GroupBy(x => x.SeatId)
                    .Select(g => g.First())
                    .ToList();

            if (uniqueTickets.Any())
            {
                await Clients.Caller.SendAsync("InforTicket", uniqueTickets, SeatStatus.Sold);
                return;
            }
            else
            {
                await Clients.Caller.SendAsync("InforTicket", null, SeatStatus.Empty);
                return;
            }
        }

        public async Task TicketBookingSuccess(TicketBookingSuccess entity)
        {
            if (_seatBeingSelected.TryGetValue(Context.ConnectionId, out TicketBookingSuccess ticketBookingSuccess))
            {
                await Clients.Group(GetGroupKey(entity.ShowTimeId, entity.RoomId)).SendAsync("ListOfSeatsSold", entity.SeatIds, SeatStatus.Sold);
            }
        }

        public Task GetWaitingSeat(Guid showTimeId, Guid roomId)
        {
            var seatIds = _seatBeingSelected.Values.Where(x => x.ShowTimeId == showTimeId && x.RoomId == roomId).SelectMany(x => x.SeatIds);
            return Clients.Caller.SendAsync("GetWaitingSeat", seatIds.ToList());
        }
    }
}