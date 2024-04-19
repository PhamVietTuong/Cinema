using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class Invoice
    {
        public Guid Id { get; set; }
        public Guid ShowTimeId { get; set; }
        public ShowTime ShowTime { get; set; }
        public Guid UserId { get; set; }
        public User User { get; set; }
		public DateTime CreationTime { get; set; }
    }
}
