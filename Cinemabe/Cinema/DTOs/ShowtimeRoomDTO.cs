using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class ShowtimeRoomDTO
    {
        public ShowTime ShowTime { get; set; }
        public Room Room { get; set; }
        public List<SeatTypeTicketTypeRowViewModel> SeatTypeTicketTypes { get; set; }
    }
}