namespace Cinema.Data.Models
{
	public class Seat
	{
		public Guid Id { get; set; }
		public Guid ShowTimeId { get; set; }
		public ShowTime ShowTime { get; set; }
		public Guid? TicketTypeId { get; set; }
		public TicketType TicketType { get; set; }
        public int ColIndex { get; set; }
        public string RowName { get; set; }
		public string Name { get; set; }
		public bool IsSold { get; set; }
	}
}
