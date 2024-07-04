using Cinema.Data.Enum;

namespace Cinema.Data.Models
{
    public class Room
    {
        public Guid Id { get; set; }
        public Guid TheaterId { get; set; }
        public Theater Theater { get; set; }
        public string Name { get; set; }
		public RoomStatus Status { get; set; }
    }
}
