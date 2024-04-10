namespace Cinema.Data.Models
{
	public class TicketType
	{
		public Guid Id { get; set; }
		public Guid ShowTimeId { get; set; }
		public ShowTime ShowTime { get; set; }
        public Guid SeatTypeId { get; set; }
        public SeatType SeatType { get; set; }
        public string Name { get; set; }
		public double Price { get; set; }
		public bool Status { get; set; }
	}
}
