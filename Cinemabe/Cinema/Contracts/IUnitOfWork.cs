namespace Cinema.Contracts
{
	public interface IUnitOfWork
	{
		IUserRepository UserRepository { get; }
		IMovieRepository MovieRepository { get; }
		IFoodAndDrinkRepository FoodAndDrinkRepository { get; }
		ITicketTypeRepository TicketTypeRepository { get; }
		ISeatRepository SeatRepository { get; }
		ITheaterRepository TheaterRepository { get; }
    }
}
