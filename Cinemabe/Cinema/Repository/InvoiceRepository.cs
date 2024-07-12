using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Enum;
using Cinema.Data.Models;
using Cinema.DTOs;
using Cinema.Helper;
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
                .Include(x => x.TicketType)
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

            string ticketTypes = "";
            Dictionary<string, int> ticketTypeCounts = new Dictionary<string, int>();

            foreach (var item in invoiceTicket)
            {
                string ticketTypeName = item.TicketType.Name;

                if (ticketTypeCounts.ContainsKey(ticketTypeName))
                {
                    ticketTypeCounts[ticketTypeName]++;
                }
                else
                {
                    ticketTypeCounts[ticketTypeName] = 1;
                }
            }

            int count = 0;
            int totalTypes = ticketTypeCounts.Count;

            foreach (var kvp in ticketTypeCounts)
            {
                count++;
                if (count == totalTypes && totalTypes > 1)
                {
                    ticketTypes += ", ";
                }
                ticketTypes += $"{kvp.Value} {kvp.Key}";
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
                TicketType = ticketTypes,
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
            var invoices = await _context.Invoice.Where(x => x.UserId == userId && x.Status == InvoiceStatus.Successful).ToListAsync();

            var result = new List<InvoiceViewModel>();

            foreach (var invoice in invoices)
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

        public async Task<List<InvoiceRowViewModel>> GetListInvoiceAsync()
        {
            var result = new List<InvoiceRowViewModel>();

            var invoices = await _context.Invoice.ToListAsync();


            foreach ( var invoice in invoices)
            {
                var invoiceTickets = await _context.InvoiceTicket
                            .Include(x => x.ShowTime)
                                .ThenInclude(st => st.Movie)
                            .Include(x => x.Room)
                                .ThenInclude(r => r.Theater)
                            .Where(x => x.Code == invoice.Code)
                            .ToListAsync();
                var invoiceFoodAndDrink = await _context.InvoiceFoodAndDrink
                            .Where(x => x.Code == invoice.Code)
                            .ToListAsync();

                result.Add(new InvoiceRowViewModel
                {
                    Code = invoice.Code,
                    MovieName = invoiceTickets.FirstOrDefault()?.ShowTime?.Movie?.Name ?? "Unknown",
                    ShowTimeStartTime = invoiceTickets.FirstOrDefault()?.ShowTime?.StartTime ?? DateTime.MinValue,
                    ShowTimeEndTime = invoiceTickets.FirstOrDefault()?.ShowTime?.EndTime ?? DateTime.MinValue,
                    RoomName = invoiceTickets.FirstOrDefault()?.Room?.Name ?? "Unknown",
                    TheaterName = invoiceTickets.FirstOrDefault()?.Room?.Theater?.Name ?? "Unknown",
                    Status = invoice.Status,
                    TotalPrice = invoiceTickets.Sum(t => t.Price) + invoiceFoodAndDrink.Sum(f => f.Price * f.Quantity),
                    CreationTime = invoice.CreationTime
                });
            }

            return result;
        }
        [Obsolete]
        public async Task<bool> SendInvoiceInfo(string code)
        {
            var invoice = await _context.Invoice
                .Include(x => x.User)
                .FirstOrDefaultAsync(x => x.Code == code);
            if (invoice == null)
            {
                return false;
            }
            else
            {
                var foods = await _context.InvoiceFoodAndDrink.Include(x => x.FoodAndDrink).Where(x => x.Code == code).ToListAsync();
                var res = new InfoReceiveMail
                {
                    Code = code,
                    Email = invoice.User.Email,
                    UserName = invoice.User.FullName
                };
                var tickets = await _context.InvoiceTicket
                    .Include(inv => inv.ShowTime)
                        .ThenInclude(inv => inv.Movie)
                    .Include(x => x.Room)
                        .ThenInclude(x => x.Theater).Where(inv => inv.Code == code).ToListAsync();
                var ticketFist = tickets.First();
                res.RoomName = ticketFist.Room.Name;
                res.TheaterName = ticketFist.Room.Theater.Name;
                res.TheaterAddress = ticketFist.Room.Theater.Address;
                res.MovieName = ticketFist.ShowTime.Movie.Name;
                res.ShowTime = ticketFist.ShowTime.StartTime.ToString("HH:mm:ss dd/MM/yyyy");

                foreach (var item in tickets)
                {
                    var ticket = new InfoProduct
                    {
                        Name = item.SeatName,
                        Price = item.Price,
                        IsTicket = true
                    };
                    res.Products.Add(ticket);
                }

                foreach (var item in foods)
                {
                    var food = new InfoProduct
                    {
                        Name = item.FoodAndDrink.Name,
                        Price = item.Price,
                        IsTicket = false
                    };
                    res.Products.Add(food);
                }
                // QRCodeGenerator qrGenerator = new();
                // qrGenerator.GenerateQRCode(code, Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "Images"));

                string pathFile = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "FormMail", "InfoInvoice.html");

                if (!File.Exists(pathFile))
                {
                    throw new FileNotFoundException($"File not found: {pathFile}");
                }
                string Content = File.ReadAllText(pathFile);

                string tableProduct = "";
                int sumTickets = res.Products.Where(x => x.IsTicket).ToList().Count;
                int sumFoodAndDrinks = res.Products.Where(x => !x.IsTicket).ToList().Count;

                foreach (var item in res.Products)
                {
                    int index = 1;
                    int quantity = 1;
                    if (item.Quantity.HasValue && item.Quantity != 0)
                    {
                        quantity = item.Quantity.Value;
                    }
                    tableProduct += $"<tr><td>{index}</td><td>{item.Name}</td><td>{item.Price}</td><td>{quantity}</td><td>{item.Price * quantity}</td></tr>";
                }
                Content = Content
                    .Replace("{{name}}", res.UserName.Split(' ').Last())
                    .Replace("{{CODE}}", res.Code)
                    .Replace("{{roomName}}", res.RoomName)
                    .Replace("{{theaterName}}", res.TheaterName)
                    .Replace("{{theaterAddress}}", res.TheaterAddress)
                    .Replace("{{movieName}}", res.MovieName)
                    .Replace("{{showtime}}", res.ShowTime)
                    .Replace("{{numSeats}}", sumTickets.ToString())
                    .Replace("{{items}}", tableProduct);
                SendMail provider = new();
                return await provider.SendEmailAsync(res.Email, $"Thông tin đặt vé xem phim - Mã thanh toán {code}", $"{Content}");
            }
        }
    }
}
