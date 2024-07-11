namespace Cinema.DTOs
{
    public class TheaterRoomDTO
    {
        public Guid TheaterId { get; set; }
        public string TheaterName { get; set; }
        public List<RoomDTO> Rooms { get; set; }
    }
}
