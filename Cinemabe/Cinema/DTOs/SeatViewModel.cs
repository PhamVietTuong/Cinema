namespace Cinema.DTOs
{
	public class SeatViewModel
	{
        public string RoomName { get; set; }
        public List<RowNameViewModel> RowName { get; set; }
    }

	public class RowNameViewModel
	{
		public string RowName { get; set; }
		public List<RowSeatViewModel> RowSeats { get; set; }
	}

    public class RowSeatViewModel 
    {
        public Guid Id { get; set; }
        public int ColIndex { get; set; }
        public bool IsSeat { get; set; }
        public string Name { get; set; }
		public Guid? SeatTypeId { get; set; }
        public string SeatTypeName { get; set; }
        public Guid TicketTypeId { get; set; }
        public string TicketTypeName { get; set; }
		public double Price { get; set; }
        public int SeatStatus { get; set; }    
    }
}
