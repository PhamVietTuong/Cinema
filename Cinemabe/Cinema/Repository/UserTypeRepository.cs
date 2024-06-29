using AutoMapper;
using Cinema.Data.Models;
using Cinema.Data;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;
using Cinema.Contracts;

namespace Cinema.Repository
{
    public class UserTypeRepository : IUserTypeRepository
    {
        private readonly CinemaContext _context;
        private readonly IMapper _mapper;

        public UserTypeRepository(CinemaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<UserTypeDTO>> GetUserTypeListAsync()
        {
            var userTypes = await _context.UserType.ToListAsync();

            var result = new List<UserTypeDTO>();
            foreach (var userType in userTypes)
            {
                result.Add(new UserTypeDTO
                {
                    Id = userType.Id,
                    Name = userType.Name,
                });
            }

            return result;
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.UserType.AnyAsync(x => x.Id == id);
        }

        public async Task<UserTypeDTO> UpdateAsync(UserTypeDTO entity)
        {
            var userType = await _context.UserType.FirstOrDefaultAsync(x => x.Id == entity.Id);

            userType.Name = entity.Name;

            await _context.SaveChangesAsync();

            return entity;
        }

        public async Task<UserTypeDTO> CreateAsync(UserTypeDTO entity)
        {
            var entityDto = _mapper.Map<UserType>(entity);

            _context.UserType.Add(entityDto);

            await _context.SaveChangesAsync();

            var resultDto = _mapper.Map<UserTypeDTO>(entityDto);

            return resultDto;
        }
    }
}
