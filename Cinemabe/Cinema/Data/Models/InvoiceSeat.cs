using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
	public class InvoiceSeat
	{
		public Guid Id { get; set; }
		public Guid InvoiceId { get; set; }
		public Invoice Invoice { get; set; }
		public Guid SeatId { get; set; }
        public Seat Seat { get; set; }
    }
}
