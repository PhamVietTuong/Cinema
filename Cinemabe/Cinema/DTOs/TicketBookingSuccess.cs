namespace Cinema.DTOs
{
    public class TicketBookingSuccess
    {
        public TicketBookingSuccess()
        {
            SeatIds = new List<string>();
        }
        public List<string> SeatIds { get; set; }
        public string ShowTimeId { get; set; }
    }
}
