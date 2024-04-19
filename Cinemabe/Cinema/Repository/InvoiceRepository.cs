using AutoMapper;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
	public class InvoiceRepository : IInvoiceRepository
	{
		private readonly CinemaContext _context;
		private readonly IMapper _mapper;

		public InvoiceRepository(CinemaContext context, IMapper mapper)
		{
			_context = context;
			_mapper = mapper;
		}

		public async Task<BookingDTO> CreateAysn(BookingDTO entity)
		{
			var invoice = await _context.AddAsync(new Invoice
			{
				ShowTimeId = entity.ShowTimeId,
				UserId = entity.UserId,
				CreationTime = DateTime.UtcNow
			});

			foreach (var seatId in entity.SeatIds)
			{
				await _context.AddAsync(new InvoiceSeat
				{
					InvoiceId = invoice.Entity.Id,
					SeatId = seatId
				});
			}

			var foodAndDrinks = await _context.FoodAndDrink.ToListAsync();
			var foodAndDrinkIds = foodAndDrinks.Select(x => x.Id).ToList();

			foreach (var foodAndDrink in entity.FoodAndDrinkIds)
			{
				if(foodAndDrinkIds.Contains(foodAndDrink.FoodAndDrinkId))
				{
					await _context.AddAsync(new InvoiceCombo
					{
						InvoiceId = invoice.Entity.Id,
						FoodAndDrinkId = foodAndDrink.FoodAndDrinkId,
						Quantity = foodAndDrink.Quantity,
					});
				}
			}

			await _context.SaveChangesAsync();

			return await FindAysn(invoice.Entity.Id);
		}

		public async Task<BookingDTO> FindAysn(Guid id)
		{
			var invoice = await _context.Invoice.Where(x => x.Id == id).FirstOrDefaultAsync();
			var bookingDTO = _mapper.Map<BookingDTO>(invoice);

			var invoiceSeat = await _context.InvoiceSeat.Where(x => x.InvoiceId == id).ToListAsync();
			var invoiceCombo = await _context.InvoiceCombo.Where(x => x.InvoiceId == id).ToListAsync();

			bookingDTO.SeatIds = invoiceSeat.Select(x => x.SeatId).ToList();

			bookingDTO.FoodAndDrinkIds = invoiceCombo.Select(x => new InvoiceComboDTO { 
				FoodAndDrinkId = x.FoodAndDrinkId,
				Quantity = x.Quantity,
			}).ToList();

			return bookingDTO;
		}

	}
}
