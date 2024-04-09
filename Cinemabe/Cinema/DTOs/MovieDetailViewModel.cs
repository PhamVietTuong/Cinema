using Cinema.Data.Models;

namespace Cinema.DTOs
{
	public class MovieDetailViewModel
	{
        public Guid Id { get; set; }
        public string AgeRestrictionName { get; set; }
        public string AgeRestrictionDescription { get; set; }
		public string Name { get; set; }
		public string Image { get; set; }
		public int Time { get; set; }
		public DateTime ReleaseDate { get; set; }
		public string Description { get; set; }
		public string Director { get; set; }
		public string Actor { get; set; }
		public string Trailer { get; set; }
		public string Languages { get; set; }
        public string MovieType { get; set; }
        public string ShowTimeTypeName { get; set; }
        public List<Schedules> Schedule { get; set; }
    }

	public class Schedules
	{
		public DateTime Date { get; set; }
		public List<Theaters> Theater { get; set; }
	}

	public class Theaters
	{
		public string TheaterName { get; set; }
		public string TheaterAddress { get; set; }
		public List<ShowTimes> ShowTime { get; set; }
	}

	public class ShowTimes
	{
		public DateTime Day { get; set; }
		public DateTime StartTime { get; set; }
		public DateTime EndTime { get; set; }
	}
}
