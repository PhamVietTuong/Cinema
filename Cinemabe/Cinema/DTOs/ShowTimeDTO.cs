namespace Cinema.DTOs
{
    public class ShowTimeDTO
    {
        public Guid Id { get; set; }
        public Guid MovieId { get; set; }
        public string MovieName { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int ProjectionForm { get; set; }
    }
}
