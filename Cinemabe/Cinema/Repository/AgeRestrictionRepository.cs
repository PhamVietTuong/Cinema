using AutoMapper;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;
    
namespace Cinema.Repository
{
    public class AgeRestrictionRepository : IAgeRestrictionRepository
    {
        private readonly CinemaContext _context;
        private readonly IMapper _mapper;

        public AgeRestrictionRepository(CinemaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<AgeRestrictionDTO>> GetAgeRestrictionListAsync()
        {
            var ageRestrictions = await _context.AgeRestriction.ToListAsync();
            
            var result = new List<AgeRestrictionDTO>();
            foreach (var ageRestriction in ageRestrictions)
            {
                result.Add(new AgeRestrictionDTO
                {
                    Id = ageRestriction.Id,
                    Name = ageRestriction.Name,
                    Description = ageRestriction.Description,
                    Abbreviation = ageRestriction.Abbreviation,
                    Status = ageRestriction.Status,
                });
            }

            return result;
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.AgeRestriction.AnyAsync(x => x.Id == id);
        }

        public async Task<AgeRestrictionDTO> UpdateAsync(AgeRestrictionDTO entity)
        {
            var ageRestriction = await _context.AgeRestriction.FirstOrDefaultAsync(x => x.Id == entity.Id);

            ageRestriction.Name = entity.Name;
            ageRestriction.Description = entity.Description;    
            ageRestriction.Abbreviation = entity.Abbreviation;
            ageRestriction.Status = entity.Status;

            await _context.SaveChangesAsync();

            return entity;
        }

        public async Task<AgeRestrictionDTO> CreateAsync(AgeRestrictionDTO entity)
        {
            var entityDto = _mapper.Map<AgeRestriction>(entity);

            _context.AgeRestriction.Add(entityDto);

            await _context.SaveChangesAsync();

            var resultDto = _mapper.Map<AgeRestrictionDTO>(entityDto);

            return resultDto;
        }
    }
}
