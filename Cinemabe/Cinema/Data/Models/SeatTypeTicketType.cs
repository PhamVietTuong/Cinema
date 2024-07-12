namespace Cinema.Data.Models
{
    public class SeatTypeTicketType
    {
        public Guid SeatTypeId { get; set; }
        public Guid TicketTypeId { get; set; }
        public double Price2D { get; set; }
        public double Price3D { get; set; }
        public double PriceDiscount2D { get; set; }
        public double PriceDiscount3D { get; set; }

        public TicketType TicketType { get; set; }
        public SeatType SeatType { get; set; }
    }
}
