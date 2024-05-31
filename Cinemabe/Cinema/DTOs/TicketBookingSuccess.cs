namespace Cinema.DTOs
{
    public class TicketBookingSuccess
    {
        public TicketBookingSuccess()
        {
            SeatIds = new List<Guid>();
        }
        public List<Guid> SeatIds { get; set; }
        public Guid ShowTimeId { get; set; }
        public Guid RoomId { get; set; }
    }
}
