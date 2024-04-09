namespace Cinema.Data.Models
{
	public class MovieShowTime
	{
        public Guid Id { get; set; }
        public Guid MovieId { get; set; }
        public Movie Movie { get; set; }
        public Guid ShowTimeId { get; set; }
        public ShowTime ShowTime { get; set; }
    }
}
