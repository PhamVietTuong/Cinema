using Cinema.DTOs;
using Microsoft.AspNetCore.SignalR;

namespace Cinema
{
    public class CinemaHub : Hub
    {
        private readonly IDictionary<string, TicketBookingSuccess> _ticketBookings;

        public CinemaHub(IDictionary<string, TicketBookingSuccess> ticketBooking)
        {
            _ticketBookings = ticketBooking;
        }

        public async Task JoinShowTime(TicketBookingSuccess entity)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, entity.ShowTimeId);

            if (!_ticketBookings.ContainsKey(entity.ShowTimeId))
            {
                _ticketBookings[entity.ShowTimeId] = entity;
            }

            await FindSeatByShowTimeId(entity.ShowTimeId);
        }

        public async Task TicketBookingSuccess(TicketBookingSuccess entity)
        {

            if (_ticketBookings.ContainsKey(entity.ShowTimeId))
            {
                var existingEntity = _ticketBookings[entity.ShowTimeId];

                existingEntity.SeatIds.AddRange(entity.SeatIds);
            }
            else
            {
                _ticketBookings[entity.ShowTimeId] = entity;
            }

            await FindSeatByShowTimeId(entity.ShowTimeId);

        }

        public Task FindSeatByShowTimeId(string showTimeId)
        {
            var seatId = _ticketBookings.Values.Where(x => x.ShowTimeId == showTimeId).Select(x => x.SeatIds).ToList();
            return Clients.Group(showTimeId).SendAsync("ListSeated", seatId);
        }
    }
}
