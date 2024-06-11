using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class InvoiceTicketDTO
    {
        public string RowName { get; set; }
        public int ColIndex { get; set; }
        public Guid TicketTypeId { get; set; }
    }
}
