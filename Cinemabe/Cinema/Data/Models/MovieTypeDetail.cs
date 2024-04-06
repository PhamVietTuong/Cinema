namespace Cinema.Data.Models
{
    public class MovieTypeDetail
    {
        public int Id { get; set; }
        public Guid MovieId { get; set; }
        public Movie Movie { get; set; }
        public Guid MovieTypeId { get; set; }
        public MovieType MovieType { get; set; }
        public bool Status { get; set; }
    }
}
