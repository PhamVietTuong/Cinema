using Cinema.Data.Enum;

namespace Cinema.Data.Models
{
    public class Invoice
    {
        public Guid UserId { get; set; }
        public string Code { get; set; }
        public InvoiceStatus Status { get; set; }
        public DateTime CreationTime { get; set; }

        public User User { get; set; }
    }
}
