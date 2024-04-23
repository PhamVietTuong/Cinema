namespace Cinema.Data.Models
{
    public class ShowTime
    {
        public Guid Id { get; set; }
        public Guid MovieId { get; set; }
        public Movie Movie { get; set; }
        public Guid RoomId { get; set; }
        public Room Room { get; set; }
		public DateTime Day { get; set; }
		public DateTime StartTime { get; set; }
		public DateTime EndTime { get; set; }
		public bool Status { get; set; }
	}
}
