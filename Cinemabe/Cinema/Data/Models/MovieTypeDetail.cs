namespace Cinema.Data.Models
{
    public class MovieTypeDetail
    {
        public int Id { get; set; }
        public int MovieId { get; set; }
        public Movie Movie { get; set; }
        public int MovieTypeId { get; set; }
        public MovieType MovieType { get; set; }
        public bool Status { get; set; }
    }
}
