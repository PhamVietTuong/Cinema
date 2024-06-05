namespace Cinema.Data.Models
{
    public class Invoice
    {
        public Guid Id { get; set; }
        public Guid UserId { get; set; }
        public string Code { get; set; }
        public DateTime CreationTime { get; set; }

        public User User { get; set; }
    }
}
