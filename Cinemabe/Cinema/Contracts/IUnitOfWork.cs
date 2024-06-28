namespace Cinema.Contracts
{
	public interface IUnitOfWork
	{
		IUserRepository UserRepository { get; }
		IMovieRepository MovieRepository { get; }
        IMovieTypeRepository MovieTypeRepository { get; }
        IFoodAndDrinkRepository FoodAndDrinkRepository { get; }
		ITicketTypeRepository TicketTypeRepository { get; }
		ISeatRepository SeatRepository { get; }
        ISeatTypeRepository SeatTypeRepository { get; }
        ITheaterRepository TheaterRepository { get; }
		IInvoiceRepository InvoiceRepository { get; }
		IAgeRestrictionRepository AgeRestrictionRepository { get; }
    }
}
