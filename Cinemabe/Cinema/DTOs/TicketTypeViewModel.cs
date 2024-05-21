namespace Cinema.DTOs
{
	public class TicketTypeViewModel
	{
        public Guid TicketTypeId { get; set; }
        public string TicketTypeName { get; set; }
        public double Price { get; set; }
        public Guid SeatTypeId { get; set; }
        public string SeatTypeName { get; set; }
    }
}
