using Cinema.Contracts;
using Cinema.Data;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class SeatTypeRepository : ISeatTypeRepository
    {
        private readonly CinemaContext _context;

        public SeatTypeRepository(CinemaContext context)
        {
            _context = context;
        }

        public async Task<List<SeatTypeTicketTypeRowViewModel>> GetSeatTypeTicketTypeByListSeatTypeId(List<Guid> seatTypeIds)
        {
            var seatTypeTicketTypes = await _context.SeatTypeTicketType
                                                    .Include(x => x.SeatType)
                                                    .Include(x => x.TicketType)
                                                    .ToListAsync();

            var result = new List<SeatTypeTicketTypeRowViewModel>();

            foreach(var seatTypeTicketType in seatTypeTicketTypes)
            {
                if(seatTypeIds.Contains(seatTypeTicketType.SeatTypeId))
                {
                    result.Add(new SeatTypeTicketTypeRowViewModel
                    {
                        SeatTypeId = seatTypeTicketType.SeatTypeId,
                        TicketTypeId = seatTypeTicketType.TicketTypeId,
                        SeatTypeName = seatTypeTicketType.SeatType.Name,
                        TicketTypeName = seatTypeTicketType.TicketType.Name,
                        Price = seatTypeTicketType.Price,
                    });
                }
            }

            return result;
        }
    }
}
