using AutoMapper;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class NewsRepository : INewsRepository
    {
        private readonly CinemaContext _context;
        private readonly IMapper _mapper;

        public NewsRepository(CinemaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<NewsDTO>> GetNewsListAsync()
        {
            var newses = await _context.News.ToListAsync();

            var result = new List<NewsDTO>();
            foreach (var news in newses)
            {
                result.Add(new NewsDTO
                {
                    Id = news.Id,
                    Title = news.Title,
                    Content = news.Content,
                    Status = news.Status,
                    CreateAt = news.CreateAt,
                    Image = news.Image,
                    UpdatedAt = news.UpdatedAt,
                });
            }

            return result;
        }
    }
}
