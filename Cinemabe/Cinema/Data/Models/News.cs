namespace Cinema.Data.Models
{
    public class News
    {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string? Content { get; set; }
        public string? Image { get; set; }
        public bool Status { get; set; }
        public DateTime CreateAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
    }
}