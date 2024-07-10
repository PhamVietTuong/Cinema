using Cinema.Data.Enum;

namespace Cinema.DTOs
{
    public class ShowTimeRoomDTO
    {
        public Guid ShowTimeId { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public ProjectionForm ProjectionForm { get; set; }
        public Guid RoomId   { get; set; }
        public string RoomName { get; set; }
        public string TheaterName { get; set; }
    }
}
