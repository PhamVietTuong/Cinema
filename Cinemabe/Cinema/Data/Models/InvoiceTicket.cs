using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class InvoiceTicket
    {
        public Guid InvoiceId { get; set; }
        public Guid ShowTimeId { get; set; }
        public Guid SeatId { get; set; }
        public Guid TicketTypeId { get; set; }
        public double Price { get; set; }

        public Invoice Invoice { get; set; }
        public ShowTime ShowTime { get; set; }
        public Seat Seat { get; set; }
        public TicketType TicketType { get; set; }
    }
}
