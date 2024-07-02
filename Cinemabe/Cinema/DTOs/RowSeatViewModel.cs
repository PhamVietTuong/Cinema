using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class RowSeatViewModel
    {
        public string RowName { get; set; }
        public int ColIndex { get; set; }
        public bool IsSeat { get; set; }
        public string Name { get; set; }
        public Guid? SeatTypeId { get; set; }
        public string SeatTypeName { get; set; }
        public SeatStatus SeatStatus { get; set; }
    }
}
