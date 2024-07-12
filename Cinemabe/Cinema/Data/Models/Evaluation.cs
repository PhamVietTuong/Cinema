using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class Evaluation
    {
        public Guid MovieId { get; set; }
        public Movie Movie { get; set; }
        public int Start { get; set; }
        public DateTime CreationDate { get; set; }
        public string Phone { get; set; }
        [ForeignKey("Phone")]
        public User User { get; set; }
    }
}