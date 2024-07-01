using AutoMapper;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class MovieTypeRepository : IMovieTypeRepository
    {
        private readonly CinemaContext _context;
        private readonly IMapper _mapper;

        public MovieTypeRepository(CinemaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<MovieTypeDTO>> GetMovieTypeListAsync()
        {
            var movieTypes = await _context.MovieType.ToListAsync();

            var result = new List<MovieTypeDTO>();
            foreach (var movieType in movieTypes)
            {
                result.Add(new MovieTypeDTO
                {
                    Id = movieType.Id,
                    Name = movieType.Name,
                    Status = movieType.Status,
                });
            }

            return result;
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.MovieType.AnyAsync(x => x.Id == id);
        }

        public async Task<MovieTypeDTO> UpdateAsync(MovieTypeDTO entity)
        {
            var movieType = await _context.MovieType.FirstOrDefaultAsync(x => x.Id == entity.Id);

            movieType.Name = entity.Name;
            movieType.Status = entity.Status;

            await _context.SaveChangesAsync();

            return entity;
        }

        public async Task<MovieTypeDTO> CreateAsync(MovieTypeDTO entity)
        {
            var entityDto = _mapper.Map<MovieType>(entity);

            _context.MovieType.Add(entityDto);

            await _context.SaveChangesAsync();

            var resultDto = _mapper.Map<MovieTypeDTO>(entityDto);

            return resultDto;
        }
    }
}
