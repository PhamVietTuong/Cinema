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

		public UnitOfWork(CinemaContext context, IMapper mapper)
        {
            _context = context;
            this._mapper = mapper;
		}

		public ITicketRepository TicketRepository => new TicketRepository(_context);
        public IUserRepository UserRepository => new UserRepository(_context);
		public IShowTimeRepository ShowTimeRepository => new ShowTimeRepository(_context);
		public IMovieRepository MovieRepository => new MovieRepository(_context);
		public IFoodAndDrinkRepository FoodAndDrinkRepository => new FoodAndDrinkRepository(_context);
		public ITicketTypeRepository TicketTypeRepository => new TicketTypeRepository(_context);
		public ISeatRepository SeatRepository => new SeatRepository(_context);
		public IInvoiceRepository InvoiceRepository => new InvoiceRepository(_context, _mapper);

		public async Task<bool> SaveChangeAsync()
        {
            return await _context.SaveChangesAsync() > 0;
        }
    }
}
