namespace Cinema.Data.Models
{
	public class Seat
	{
		public Guid RoomId { get; set; }
		public Guid? SeatTypeId { get; set; }
        public int ColIndex { get; set; }
        public string RowName { get; set; }
		public bool IsSeat { get; set; }

        public Room Room { get; set; }
        public SeatType SeatType { get; set; }
    }
}
