using AutoMapper;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Enum;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class TicketTypeRepository : ITicketTypeRepository
    {
        private readonly CinemaContext _context;
        private readonly IMapper _mapper;

        public TicketTypeRepository(CinemaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<TicketTypeViewModel>> TicketTypeByShowTimeAndRoomAsync(TicketTypeByShowTimeAndRoomDTO ticketTypeByShowTimeDTO)
        {
            var showTimeRoom = (await _context.ShowTimeRoom.Include(x => x.ShowTime).Where(x => x.ShowTimeId == ticketTypeByShowTimeDTO.ShowTimeId && x.RoomId == ticketTypeByShowTimeDTO.RoomId).ToListAsync()).FirstOrDefault();
            var seatTypeTicketTypes = await _context.SeatTypeTicketType.Include(x => x.TicketType).Include(x => x.SeatType).ToListAsync();
            var seatTypeIds = await _context.Seat.Where(x => x.RoomId == showTimeRoom.RoomId).Select(x => x.SeatTypeId).Distinct().ToListAsync();
            var rows = new List<TicketTypeViewModel>();

            TimeSpan timeMorning = new(10, 0, 0);
            TimeSpan timeNight = new(22, 0, 0);
            var showtime = showTimeRoom.ShowTime;

            foreach (var seatTypeTicketType in seatTypeTicketTypes)
            {
                if (seatTypeIds.Contains(seatTypeTicketType.SeatTypeId))
                {
                    var lastPrice = 0.0;
                    if (showtime.ProjectionForm == ProjectionForm.Time2D)
                    {
                        lastPrice = showtime.StartTime.TimeOfDay >= timeMorning && showtime.StartTime.TimeOfDay <= timeNight ?
                            seatTypeTicketType.Price2D :
                            seatTypeTicketType.PriceDiscount2D;
                    }else{
                        lastPrice = showtime.StartTime.TimeOfDay >= timeMorning && showtime.StartTime.TimeOfDay <= timeNight ?
                            seatTypeTicketType.Price3D :
                            seatTypeTicketType.PriceDiscount3D;
                    }

                    var vm = new TicketTypeViewModel
                    {
                        SeatTypeId = seatTypeTicketType.SeatTypeId,
                        TicketTypeId = seatTypeTicketType.TicketTypeId,
                        TicketTypeName = seatTypeTicketType.TicketType.Name,
                        Price = lastPrice,
                        SeatTypeName = seatTypeTicketType.SeatType.Name,
                    };

                    rows.Add(vm);
                }
            }
            return rows;
        }

        public async Task<List<TicketTypeDTO>> GetTicketTypeListAsync()
        {
            var ticketTypes = await _context.TicketType.ToListAsync();

            var result = new List<TicketTypeDTO>();
            foreach (var ticketType in ticketTypes)
            {
                result.Add(new TicketTypeDTO
                {
                    Id = ticketType.Id,
                    Name = ticketType.Name,
                    Status = ticketType.Status,
                });
            }

            return result;
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.TicketType.AnyAsync(x => x.Id == id);
        }

        public async Task<TicketTypeDTO> UpdateAsync(TicketTypeDTO entity)
        {
            var ticketType = await _context.TicketType.FirstOrDefaultAsync(x => x.Id == entity.Id);

            ticketType.Name = entity.Name;
            ticketType.Status = entity.Status;

            await _context.SaveChangesAsync();

            return entity;
        }

        public async Task<TicketTypeDTO> CreateAsync(TicketTypeDTO entity)
        {
            var entityDto = _mapper.Map<TicketType>(entity);

            _context.TicketType.Add(entityDto);

            await _context.SaveChangesAsync();

            var resultDto = _mapper.Map<TicketTypeDTO>(entityDto);

            return resultDto;
        }
    }
}
