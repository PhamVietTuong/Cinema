namespace Cinema.Contracts
{
	public interface IUnitOfWork
	{
		ITicketRepository TicketRepository { get; }
		IUserRepository UserRepository { get; }
		IShowTimeRepository ShowTimeRepository { get; }
		IMovieRepository MovieRepository { get; }
		IFoodAndDrinkRepository FoodAndDrinkRepository { get; }
		Task<bool> SaveChangeAsync();
	}
}
