namespace Cinema.Data.Models
{
    public class ShowTime
    {
        public int Id { get; set; }
        public int MovieId { get; set; }
        public Movie Movie { get; set; }    
        public DateTime Day { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set;}
        public int TheaterId { get; set; }
        public Theater Theater { get; set; }
        public int RoomId { get; set; }
        public Room Room { get; set; }
        public int ShowTimeTypeId { get; set; }
        public ShowTimeType ShowTimeType { get; set; }
        public bool Status { get; set; }
    }
}
