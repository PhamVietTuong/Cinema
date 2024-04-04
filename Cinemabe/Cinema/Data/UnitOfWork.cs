using Cinema.Contracts;
using Cinema.Data.Models;
using Cinema.Repository;
using Microsoft.AspNetCore.Identity;

namespace Cinema.Data
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly CinemaContext _context;
		private readonly UserManager<User> _userManager;
		private readonly RoleManager<IdentityRole> _roleManager;

		public UnitOfWork(CinemaContext context, UserManager<User> userManager, RoleManager<IdentityRole> roleManager)
        {
            _context = context;
            _userManager = userManager;
            this._roleManager = roleManager;
		}

		public ITicketRepository TicketRepository => new TicketRepository(_context);
        public IUserRepository UserRepository => new UserRepository(_context, _userManager, _roleManager);
		public IShowTimeRepository ShowTimeRepository => new ShowTimeRepository(_context);
		public IMovieRepository MovieRepository => new MovieRepository(_context);

		public async Task<bool> SaveChangeAsync()
        {
            return await _context.SaveChangesAsync() > 0;
        }
    }
}
