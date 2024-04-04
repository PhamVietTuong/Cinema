namespace Cinema.DTOs
{
	public class MovieViewModel
	{
		public int Id { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public int Time { get; set; }
        public DateTime ReleaseDate { get; set; }
        public string Description { get; set; }
		public string Trailer { get; set; }
    }
}
