namespace Cinema.DTOs
{
	public class SeatViewModel
	{
		public string RowName { get; set; }
		public List<RowSeatViewModel> RowSeats { get; set; }
	}

    public class RowSeatViewModel 
    {
        public Guid Id { get; set; }
        public bool IsSold { get; set; }
        public string Name { get; set; }
        public string SeatTypeName { get; set; }
		public Guid TicketTypeId { get; set; }
		public string TicketTypeName { get; set; }
		public double Price { get; set; }
	}
}
