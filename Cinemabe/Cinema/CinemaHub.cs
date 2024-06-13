using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;

namespace Cinema
{
    public class CinemaHub : Hub
    {
        private readonly IDictionary<string, InfoTicketBooking> _seatBeingSelected;
        private readonly CinemaContext _context;

        public CinemaHub(IDictionary<string, InfoTicketBooking> seatBeingSelected, CinemaContext context)
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
            if (_seatBeingSelected.TryGetValue(Context.ConnectionId, out InfoTicketBooking entity))
            {
                _seatBeingSelected.Remove(Context.ConnectionId);
                Clients.Group(GetGroupKey(entity.ShowTimeId, entity.RoomId)).SendAsync("UpdateSeat", entity.InfoSeats, SeatStatus.Empty);
            }

            return base.OnDisconnectedAsync(exception);
        }

        public async Task SeatBeingSelected(InfoTicketBooking entity)
        {
            var selfSeats = _seatBeingSelected[Context.ConnectionId].InfoSeats;
            var allSeatsExceptSelf = _seatBeingSelected.Values
                .Where(x => x.ShowTimeId == entity.ShowTimeId && x.RoomId == entity.RoomId)
                .SelectMany(x => x.InfoSeats)
                .Except(selfSeats)
                .ToList();

            foreach (var seat in allSeatsExceptSelf)
            {
                if (entity.InfoSeats.Any(y => y.RowName == seat.RowName && y.ColIndex == seat.ColIndex))
                {
                    await Clients.Caller.SendAsync("CheckForEmptySeats", seat, SeatStatus.Waiting);
                    return;
                }
            }

            var bookedSeats = new List<InfoSeat>();
            foreach (var infoSeat in entity.InfoSeats)
            {
                var seats = await _context.InvoiceTicket
                    .Include(x => x.Seat)
                    .Where(x => x.ShowTimeId == entity.ShowTimeId &&
                                x.Seat.RoomId == entity.RoomId &&
                                x.Seat.RowName == infoSeat.RowName &&
                                x.Seat.ColIndex == infoSeat.ColIndex)
                    .Select(x => new InfoSeat { RowName = x.Seat.RowName, ColIndex = x.Seat.ColIndex })
                    .ToListAsync();

                bookedSeats.AddRange(seats);
            }

            if (bookedSeats.Any())
            {
                await Clients.Caller.SendAsync("CheckForEmptySeats", bookedSeats, SeatStatus.Sold);
                return;
            }

            if (!_seatBeingSelected.ContainsKey(Context.ConnectionId))
            {
                _seatBeingSelected[Context.ConnectionId] = entity;

            }

            if (_seatBeingSelected.ContainsKey(Context.ConnectionId))
            {
                var seats = _seatBeingSelected[Context.ConnectionId].InfoSeats;

                var seatsToRemove = seats.Where(seat => !entity.InfoSeats.Any(infoSeat => infoSeat.RowName == seat.RowName && infoSeat.ColIndex == seat.ColIndex)).ToList();

                foreach (var seatIdToRemove in seatsToRemove)
                {
                    seats.Remove(seatIdToRemove);
                }

                var seatsToAdd = new List<InfoSeat>();

                foreach (var seat in entity.InfoSeats)
                {
                    if (!seats.Any(x => x.ColIndex == seat.ColIndex && x.RowName == seat.RowName))
                    {
                        seats.Add(seat);
                        seatsToAdd.Add(seat);
                    };
                }

                if (seatsToAdd.Any())
                {
                    await Clients.OthersInGroup(GetGroupKey(entity.ShowTimeId, entity.RoomId)).SendAsync("UpdateSeat", seatsToAdd, SeatStatus.Waiting);
                }

                if (seatsToRemove.Any())
                {
                    await Clients.OthersInGroup(GetGroupKey(entity.ShowTimeId, entity.RoomId)).SendAsync("UpdateSeat", seatsToRemove, SeatStatus.Empty);
                }
            }
        }

        public async Task JoinShowTime(InfoTicketBooking entity)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, GetGroupKey(entity.ShowTimeId, entity.RoomId));

            _seatBeingSelected[Context.ConnectionId] = entity;

            await GetWaitingSeat(entity.ShowTimeId, entity.RoomId);
        }

        public async Task<InvoiceDTO> CheckTheSeatBeforeBooking(InvoiceDTO entity)
        {
            try
            {
                var tickets = await _context.InvoiceTicket
                     .Include(x => x.Seat)
                     .Where(x => x.ShowTimeId == entity.ShowTimeId && x.RoomId == entity.RoomId)
                     .ToListAsync();

                var bookedSeats = tickets
                    .Where(ticket => entity.InvoiceTickets.Any(invoiceSeat =>
                        ticket.Seat.RowName == invoiceSeat.RowName &&
                        ticket.Seat.ColIndex == invoiceSeat.ColIndex))
                    .ToList();

                if (bookedSeats.Any())
                {
                    await Clients.Caller.SendAsync("InforTicket", bookedSeats, SeatStatus.Sold);
                    return null;
                }
                else
                {
                    var invoice = new Invoice
                    {
                        UserId = entity.UserId,
                        Code = DateTime.Now.ToString("yyMMddhhmmss"),
                        CreationTime = DateTime.Now,
                    };

                    await _context.Invoice.AddAsync(invoice);

                    foreach (var seat in entity.InvoiceTickets)
                    {
                        var invoiceTicket = new InvoiceTicket
                        {
                            InvoiceId = invoice.Id,
                            ShowTimeId = entity.ShowTimeId,
                            RoomId = entity.RoomId,
                            ColIndex = seat.ColIndex,
                            RowName = seat.RowName,
                            TicketTypeId = seat.TicketTypeId,
                            Price = await CalculatePriceAsync(seat.TicketTypeId, seat.RowName, seat.ColIndex, entity.RoomId)
                        };

                        await _context.InvoiceTicket.AddAsync(invoiceTicket);
                    }

                    foreach (var item in entity.FoodAndDrinks)
                    {
                        if (item.Quantity <= 0) break;

                        var invoiceFoodAndDrink = new InvoiceFoodAndDrink
                        {
                            InvoiceId = invoice.Id,
                            FoodAndDrinkId = item.FoodAndDrinkId,
                            Quantity = item.Quantity,
                            Price = _context.FoodAndDrinkTheater.FirstOrDefault(x => x.FoodAndDrinkId == item.FoodAndDrinkId && x.TheaterId == entity.TheaterId).Price,
                        };

                        await _context.InvoiceFoodAndDrink.AddAsync(invoiceFoodAndDrink);
                    }

                    await _context.SaveChangesAsync();

                    await Clients.Group(GetGroupKey(entity.ShowTimeId, entity.RoomId)).SendAsync("ListOfSeatsSold", entity.InvoiceTickets.Select(x => new { x.RowName, x.ColIndex }), SeatStatus.Sold);

                    return entity;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in CheckTheSeatBeforeBooking: {ex.Message}");
                throw;
            }
        }

        private async Task<double> CalculatePriceAsync(Guid ticketTypeId, string rowName, int colIndex, Guid roomId)
        {
            var seatType = await _context.Seat.FirstOrDefaultAsync(x => x.RowName == rowName && x.ColIndex == colIndex && x.RoomId == roomId);
            if (seatType == null)
            {
                return 0;
            }

            return await _context.SeatTypeTicketType
                    .Where(x => x.TicketTypeId == ticketTypeId && x.SeatTypeId == seatType.SeatTypeId)
                    .Select(x => x.Price)
                    .FirstOrDefaultAsync();
        }


        public Task GetWaitingSeat(Guid showTimeId, Guid roomId)
        {
            var seatIds = _seatBeingSelected.Values.Where(x => x.ShowTimeId == showTimeId && x.RoomId == roomId).SelectMany(x => x.InfoSeats);
            return Clients.Caller.SendAsync("GetWaitingSeat", seatIds.ToList());
        }
    }
}