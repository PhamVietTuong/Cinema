namespace Cinema.DTOs
{
    public class SeatTypeTicketTypeRowViewModel
    {
        public Guid SeatTypeId { get; set; }
        public Guid TicketTypeId { get; set; }
        public string SeatTypeName { get; set; }
        public string TicketTypeName { get; set; }
        public double Price { get; set; }
    }
}
