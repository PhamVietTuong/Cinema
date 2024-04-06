using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class Invoice
    {
        public Guid Id { get; set; }
        [ForeignKey("UserId")]
        //public string UserId { get; set; }
        //public User User { get; set; }
		public Guid TicketId { get; set; }
		public Ticket Ticket { get; set; }
		public double TotalProduct { get; set; }
		public DateTime CreationTime { get; set; }
        public bool Status { get; set; }
    }
}
