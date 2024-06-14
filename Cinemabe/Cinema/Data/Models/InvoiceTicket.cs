using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class InvoiceTicket
    {
        public string Code { get; set; }
        public Guid ShowTimeId { get; set; }
        public Guid RoomId { get; set; }
        public int ColIndex { get; set; }
        public string RowName { get; set; }
        public Guid TicketTypeId { get; set; }
        public string SeatName { get; set; }
        public double Price { get; set; }

        [ForeignKey("Code")]
        public Invoice Invoice { get; set; }
        public ShowTime ShowTime { get; set; }
        [ForeignKey("RoomId, ColIndex, RowName")]
        public Seat Seat { get; set; }
        public TicketType TicketType { get; set; }
        public Room Room { get; set; }
    }
}
