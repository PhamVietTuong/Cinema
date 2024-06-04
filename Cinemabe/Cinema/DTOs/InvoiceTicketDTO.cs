using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class InvoiceTicketDTO
    {
        public Guid SeatId { get; set; }
        public Guid TicketTypeId { get; set; }
    }
}
