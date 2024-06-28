using AutoMapper;
using Cinema.Contracts;
using Cinema.Data.Models;
using Cinema.Repository;
using Microsoft.AspNetCore.Identity;

namespace Cinema.Data
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly CinemaContext _context;
		private readonly IMapper _mapper;
        private readonly IConfiguration _configuration;

        public UnitOfWork(CinemaContext context, IMapper mapper, IConfiguration configuration)
        {
            _context = context;
            _mapper = mapper;
            _configuration = configuration;
        }

        public IUserRepository UserRepository => new UserRepository(_context, _configuration);
		public IMovieRepository MovieRepository => new MovieRepository(_context);
        public IMovieTypeRepository MovieTypeRepository => new MovieTypeRepository(_context, _mapper);
        public IFoodAndDrinkRepository FoodAndDrinkRepository => new FoodAndDrinkRepository(_context);
		public ITicketTypeRepository TicketTypeRepository => new TicketTypeRepository(_context, _mapper);
		public ISeatRepository SeatRepository => new SeatRepository(_context);
		public ITheaterRepository TheaterRepository => new TheaterRepository(_context);
		public IInvoiceRepository InvoiceRepository => new InvoiceRepository(_context);
		public IAgeRestrictionRepository AgeRestrictionRepository => new AgeRestrictionRepository(_context, _mapper);
    }
}
