using Cinema.Data.Enum;

namespace Cinema.DTOs
{
    public class InvoiceRowViewModel
    {
        public string Code { get; set; }
        public string MovieName { get; set; }
        public DateTime ShowTimeStartTime { get; set; }
        public DateTime ShowTimeEndTime { get; set; }
        public string RoomName { get; set; }
        public string TheaterName { get; set; }
        public InvoiceStatus Status { get; set; }
        public double TotalPrice { get; set; }
        public DateTime CreationTime { get; set; }
    }
}
