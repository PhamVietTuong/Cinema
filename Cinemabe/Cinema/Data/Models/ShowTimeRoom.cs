namespace Cinema.Data.Models
{
    public class ShowTimeRoom
    {
        public Guid Id { get; set; }
        public Guid ShowTimeId { get; set; }
        public ShowTime ShowTime { get; set; }
        public Guid RoomId { get; set; }
        public Room Room { get; set; }
    }
}
