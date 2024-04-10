using Cinema.Contracts;
using Cinema.Data;
using Cinema.DTOs;
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

		public async Task<List<SeatViewModel>> GetSeatByShowTimeAysn(Guid showTimeId)
		{
			var seats = await _context.Seats
											.Include(x => x.TicketType)
												.ThenInclude(x => x.SeatType)
											.Where(x => x.TicketType.ShowTimeId == showTimeId)
											.ToListAsync();
			var rowName = seats.GroupBy(x => new { x.RowName })
								.Select(rowNameViewModel => new SeatViewModel
								{
									RowName = rowNameViewModel.Key.RowName,
									RowSeats = rowNameViewModel.Select(rowSeatViewModel => new RowSeatViewModel
									{
										Id = rowSeatViewModel.Id,
										IsSold = rowSeatViewModel.IsSold,
										Name = rowSeatViewModel.Name,
										SeatTypeName = rowSeatViewModel.TicketType.SeatType.Name,
										TicketTypeId = rowSeatViewModel.TicketType.Id,
										TicketTypeName = rowSeatViewModel.TicketType.Name,
										Price = rowSeatViewModel.TicketType.Price,
									}).ToList()

								}).ToList();

			return rowName;
		}
	}
}
