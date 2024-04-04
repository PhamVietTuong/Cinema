using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class Ticket
    {
        public int Id { get; set; }

        //public int ChairId { get; set; }
        //public Chair Chair { get; set; }

        //public int MovieId { get; set; }
        //public Movie Movie { get; set; }

        //public int TheaterId { get; set; }
        //public Theater Theater { get; set; }

        public int ShowTimeId { get; set; }
        public ShowTime ShowTime { get; set; }

        [ForeignKey("UserId")]
        public string UserId { get; set; }
        public User User { get; set; }

        public bool Status { get; set; }
    }
}
