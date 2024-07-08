namespace Cinema.Data.Models
{
    public class Evaluation
    {
        public Guid UserId { get; set; }
        public User User { get; set; }
        public Guid MovieId { get; set; }
        public Movie Movie { get; set; }
        public int Start { get; set; }
        public DateTime CreationDate { get; set; }
    }
}