using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Enum;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class InvoiceRepository : IInvoiceRepository
    {
        private readonly CinemaContext _context;

        public InvoiceRepository(CinemaContext context)
        {
            _context = context;
        }

        public async Task<InvoiceViewModel> GetInvoiceAsync(string code)
        {
            var invoice = await _context.Invoice
                .FirstOrDefaultAsync(x => x.Code == code);
            var invoiceTicket = await _context.InvoiceTicket
                .Include(x => x.ShowTime)
                    .ThenInclude(x => x.Movie)
                        .ThenInclude(x => x.AgeRestriction)
                .Include(x => x.Room)
                    .ThenInclude(x => x.Theater)
                .Where(x => x.Code == invoice.Code).ToListAsync();
            var invoiceTicketShowTime = invoiceTicket.Select(x => x.ShowTime).FirstOrDefault();
            var invoiceTicketRoom = invoiceTicket.Select(x => x.Room).FirstOrDefault();
            var invoiceFoodAndDrink = await _context.InvoiceFoodAndDrink
                .Include(x => x.FoodAndDrink)
                .Where(x => x.Code == invoice.Code).ToListAsync();
            var resultFoodAndDrinks = new List<InvoiceFoodAndDrinkViewModel>();

            bool isDulexe = invoiceTicketRoom != null ? _context.Seat.Include(x => x.SeatType).Where(x => x.RoomId == invoiceTicketRoom.Id).Any(x => x.SeatType.Name == "Nằm") : false;

            foreach (var item in invoiceFoodAndDrink)
            {
                resultFoodAndDrinks.Add(new InvoiceFoodAndDrinkViewModel
                {
                    FoodAndDrinkName = item.FoodAndDrink.Name,
                    Quantity = item.Quantity,
                });
            }

            var result = new InvoiceViewModel
            {
                MovieImage = invoiceTicketShowTime.Movie.Image,
                MovieName = invoiceTicketShowTime.Movie.Name,
                ProjectionFormText = invoiceTicketShowTime.ProjectionForm == ProjectionForm.Time2D ? "2D" : "3D",
                AgeRestrictionDescription = invoiceTicketShowTime.Movie.AgeRestriction.Description,
                AgeRestrictionName = invoiceTicketShowTime.Movie.AgeRestriction.Name,
                TheaterName = invoiceTicketRoom.Theater.Name,
                Code = invoice.Code,
                ShowTimeStartTime = invoiceTicketShowTime.StartTime,
                RoomName = invoiceTicketRoom.Name,
                NumberTicket = invoiceTicket.Count(),
                ShowTimeType = isDulexe ? "Deluxe" : "Standard",
                SeatName = String.Join(", ", invoiceTicket.Select(x => x.SeatName)),
                FoodAndDrinks = resultFoodAndDrinks,
                TheaterAddress = invoiceTicketRoom.Theater.Address,
            };

            return result;
        }

        public async Task<bool> UpdateCodeStatusAsync(string code, int resultCode)
        {
            var order = await _context.Invoice.FirstOrDefaultAsync(o => o.Code == code);

            if (order == null)
            {
                return false;
            }

            if (resultCode == 0)
            {
                order.Status = InvoiceStatus.Successful;
            }
            else
            {
                order.Status = InvoiceStatus.Failed;
            }

            _context.Invoice.Update(order);
            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<List<InvoiceViewModel>> InvoiceListOfUserAsync(Guid? userId)
        {
            var invoices = await _context.Invoice.Where(x => x.UserId == userId).ToListAsync();

            var result = new List<InvoiceViewModel>();  

            foreach(var invoice in invoices)
            {
                var invoiceTicket = await _context.InvoiceTicket
                    .Include(x => x.Room)
                        .ThenInclude(x => x.Theater)
                    .Include(x => x.ShowTime)
                    .FirstOrDefaultAsync(x => x.Code == invoice.Code);
                var invoiceTickets = await _context.InvoiceTicket.Where(x => x.Code == invoice.Code).ToListAsync();
                var invoiceFoodAndDrinks = await _context.InvoiceFoodAndDrink.Where(x => x.Code == invoice.Code).ToListAsync();

                result.Add(new InvoiceViewModel
                {
                    Code = invoice.Code,
                    TheaterName = invoiceTicket.Room.Theater.Name,
                    ShowTimeStartTime = invoiceTicket.ShowTime.StartTime,
                    TotalPrice = invoiceTickets.Select(x => x.Price).Sum() + invoiceFoodAndDrinks.Select(x => x.Price * x.Quantity).Sum(),
                });
            }

            return result.OrderBy(x => x.ShowTimeStartTime).ToList();
        }
        public async Task<List<RevenueTheaterViewModel>> GetRevenueAsync(FilterRevenue filterRevenue)
        {
            var startDate = filterRevenue.StartDate ?? DateTime.MinValue;
            var endDate = filterRevenue.EndDate ?? DateTime.MaxValue;

            var theaters = await _context.Theater.Where(x => x.Status).ToListAsync();
            var result = new List<RevenueTheaterViewModel>();

            foreach (var theater in theaters)
            {
                var totalSeat = await _context.InvoiceTicket
                    .Where(x => x.Invoice.CreationTime >= startDate
                                && x.Invoice.CreationTime <= endDate
                                && x.Room.TheaterId == theater.Id)
                    .SumAsync(x => x.Price);

                var totalFoodAndDrink = await _context.InvoiceFoodAndDrink
                    .Where(x => x.Invoice.CreationTime >= startDate
                                && x.Invoice.CreationTime <= endDate
                                && x.TheaterId == theater.Id)
                    .SumAsync(x => x.Price * x.Quantity);
                result.Add(new RevenueTheaterViewModel
                {
                    TheaterName = theater.Name,
                    TotalSeat = totalSeat,
                    TotalFoodAndDrink = totalFoodAndDrink,
                    TotalPrice = totalSeat + totalFoodAndDrink
                });
            }

            return result;
        }

    }
}
