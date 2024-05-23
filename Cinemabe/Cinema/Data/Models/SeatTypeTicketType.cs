namespace Cinema.Data.Models
{
    public class SeatTypeTicketType
    {
        public Guid SeatTypeId { get; set; }
        public Guid TicketTypeId { get; set; }
        public double Price { get; set; }

        public TicketType TicketType { get; set; }
        public SeatType SeatType { get; set; }
    }
}
