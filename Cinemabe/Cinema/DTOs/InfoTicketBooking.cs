namespace Cinema.DTOs
{
    public class InfoTicketBooking
    {
        public InfoTicketBooking()
        {
            InfoSeats = new List<InfoSeat>();
        }
        public List<InfoSeat> InfoSeats { get; set; }
        public Guid ShowTimeId { get; set; }
        public Guid RoomId { get; set; }
    }
}
