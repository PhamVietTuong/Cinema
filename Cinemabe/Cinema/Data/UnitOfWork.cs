using Cinema.Contracts;
using Cinema.Repository;

namespace Cinema.Data
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly CinemaContext _context;

        public UnitOfWork(CinemaContext context)
        {
            _context = context;
        }

        public ITicketRepository TicketRepository => new TicketRepository(_context);

        public async Task<bool> SaveChangeAsync()
        {
            return await _context.SaveChangesAsync() > 0;
        }
    }
}
