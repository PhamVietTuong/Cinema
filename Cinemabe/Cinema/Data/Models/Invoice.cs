using Cinema.Data.Enum;
using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class Invoice
    {
        public string Code { get; set; }
        public InvoiceStatus Status { get; set; }
        public DateTime CreationTime { get; set; }

        public string Phone { get; set; }
        [ForeignKey("Phone")]
        public User User { get; set; }
    }
}
