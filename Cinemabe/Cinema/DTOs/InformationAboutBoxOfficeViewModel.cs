namespace Cinema.DTOs
{
	public class InformationAboutBoxOfficeViewModel
	{
        public Guid Id { get; set; }
        public string TheaterName { get; set; }
        public string TheaterAddress { get; set; }
        public string ShowTimeTypeName { get; set; }
        public DateTime Day { get; set; }
		public DateTime StartTime { get; set; }
		public DateTime EndTime { get; set; }
		public MoviesInformation MoviesInformation { get; set; }
		public List<ListChair> ListChair { get; set; }
	}

    public class MoviesInformation 
    {
        public string AgeRestrictionName { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public int Time { get; set; }
		public DateTime ReleaseDate { get; set; }
		public string Description { get; set; }
		public string Director { get; set; }
		public string Actor { get; set; }
		public string Trailer { get; set; }
		public string Languages { get; set; }
	}

	public class ListChair
	{
        public string ChairTypeName { get; set; }
        public double Price { get; set; }
        public string RowChairName { get; set; }
        public string Name { get; set; }
        public bool IsSold { get; set; }
    }
}
