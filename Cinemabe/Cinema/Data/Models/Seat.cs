namespace Cinema.Data.Models
{
	public class Seat
	{
		public Guid Id { get; set; }
		public Guid TicketTypeId { get; set; }
		public TicketType TicketType { get; set; }
        public string RowName { get; set; }
		public string RowSeat { get; set; }
		public bool IsSold { get; set; }
	}
}
