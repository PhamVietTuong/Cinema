using AutoMapper;
using Cinema.Data.Models;
using Cinema.Data;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;
using Cinema.Contracts;

namespace Cinema.Repository
{
    public class SeatTypeRepository : ISeatTypeRepository
    {
        private readonly CinemaContext _context;
        private readonly IMapper _mapper;

        public SeatTypeRepository(CinemaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<SeatTypeDTO>> GetSeatTypeListAsync()
        {
            var seatTypes = await _context.SeatType.ToListAsync();

            var result = new List<SeatTypeDTO>();
            foreach (var seatType in seatTypes)
            {
                result.Add(new SeatTypeDTO
                {
                    Id = seatType.Id,
                    Name = seatType.Name,
                    Status = seatType.Status,
                });
            }

            return result;
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.SeatType.AnyAsync(x => x.Id == id);
        }

        public async Task<SeatTypeDTO> UpdateAsync(SeatTypeDTO entity)
        {
            var seatType = await _context.SeatType.FirstOrDefaultAsync(x => x.Id == entity.Id);

            seatType.Name = entity.Name;
            seatType.Status = entity.Status;

            await _context.SaveChangesAsync();

            return entity;
        }

        public async Task<SeatTypeDTO> CreateAsync(SeatTypeDTO entity)
        {
            var entityDto = _mapper.Map<SeatType>(entity);

            _context.SeatType.Add(entityDto);

            await _context.SaveChangesAsync();

            var resultDto = _mapper.Map<SeatTypeDTO>(entityDto);

            return resultDto;
        }
    }
}
