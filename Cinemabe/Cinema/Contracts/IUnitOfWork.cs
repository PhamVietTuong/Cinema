namespace Cinema.Contracts
{
	public interface IUnitOfWork
	{
		ITicketRepository TicketRepository { get; }
		IUserRepository UserRepository { get; }
		IMovieRepository MovieRepository { get; }
		IFoodAndDrinkRepository FoodAndDrinkRepository { get; }
		ITicketTypeRepository TicketTypeRepository { get; }
		ISeatRepository SeatRepository { get; }
		ITheaterRepository TheaterRepository { get; }
        Task<bool> SaveChangeAsync();
	}
}
