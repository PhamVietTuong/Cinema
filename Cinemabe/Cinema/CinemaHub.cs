using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.SignalR;
using System.Linq;

namespace Cinema
{
    public class CinemaHub : Hub
    {
        private readonly IDictionary<string, TicketBookingSuccess> _seatBeingSelected;

        public CinemaHub(IDictionary<string, TicketBookingSuccess> seatBeingSelected)
        {
            _seatBeingSelected = seatBeingSelected;
        }

        public override Task OnDisconnectedAsync(Exception exception)
        {
            if (_seatBeingSelected.TryGetValue(Context.ConnectionId, out TicketBookingSuccess entity))
            {
                _seatBeingSelected.Remove(Context.ConnectionId);
                Clients.Group($"{entity.ShowTimeId}-{entity.ShowTimeId}").SendAsync("SeatDisconnection", entity.SeatIds.ToList());
            }

            return base.OnDisconnectedAsync(exception);
        }

        public async Task SeatBeingSelected(TicketBookingSuccess entity)
        {
            var selfSeatIds = _seatBeingSelected[Context.ConnectionId].SeatIds;
            var allSeatIdsExceptSelf = _seatBeingSelected.Values
                .Where(x => x.ShowTimeId == entity.ShowTimeId)
                .SelectMany(x => x.SeatIds)
                .Except(selfSeatIds)
                .ToList();

            foreach (var seatId in allSeatIdsExceptSelf)
            {
                if (entity.SeatIds.Contains(seatId))
                {
                    await FindListSeatBeingSelectedByShowTimeId(entity.ShowTimeId, seatId);
                    return;
                }
            }

            if (!_seatBeingSelected.ContainsKey(Context.ConnectionId))
            {
                _seatBeingSelected[Context.ConnectionId] = entity;

            }

            if (_seatBeingSelected.ContainsKey(Context.ConnectionId))
            {
                var seatIds = _seatBeingSelected[Context.ConnectionId].SeatIds;
                var seatsToRemove = new List<string>();

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

                foreach (var seatId in entity.SeatIds)
                {
                    if (!seatIds.Any(x => x == seatId))
                    {
                        seatIds.Add(seatId);
                    }
                }
            }

            await Clients.OthersInGroup($"{entity.ShowTimeId}-{entity.ShowTimeId}").SendAsync("ListOfSeatTheUserIsCurrentlySelecting", entity.SeatIds.ToList(), null);
            //await AllSeat(entity.ShowTimeId, null);
        }

        public async Task JoinShowTime(TicketBookingSuccess entity)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, $"{entity.ShowTimeId}-{entity.ShowTimeId}");


            _seatBeingSelected[Context.ConnectionId] = entity;


            await FindListSeatBeingSelectedByShowTimeId(entity.ShowTimeId, null);

        }

        public async Task TicketBookingSuccess(TicketBookingSuccess entity)
        {
            if (_seatBeingSelected.TryGetValue(Context.ConnectionId, out TicketBookingSuccess ticketBookingSuccess))
            {
                await Clients.Group($"{entity.ShowTimeId}-{entity.ShowTimeId}").SendAsync("ListSeated", entity.SeatIds);
            }
        }

        public Task FindListSeatBeingSelectedByShowTimeId(string showTimeId, string seatHasBeenChosen)
        {
            var seatIds = _seatBeingSelected.Values.Where(x => x.ShowTimeId == showTimeId).SelectMany(x => x.SeatIds);
            return Clients.Caller.SendAsync("ListOfSeatTheUserIsCurrentlySelecting", seatIds.ToList(), seatHasBeenChosen);
        }

        public Task AllSeat(string showTimeId, string seatHasBeenChosen)
        {
            var seatIds = _seatBeingSelected.Values.Where(x => x.ShowTimeId == showTimeId).SelectMany(x => x.SeatIds);
            return Clients.Caller.SendAsync("AllSeat", seatIds.ToList(), seatHasBeenChosen);
        }
    }
}