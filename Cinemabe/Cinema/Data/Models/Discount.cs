namespace Cinema.Data.Models
{
    public class Discount
    {
        public string Code { get; set; }
        public Guid DiscountTypeId { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public string Description { get; set; }
        public bool ForMember { get; set; }
        public double DiscountValue { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }

        public DiscountType DiscountType { get; set; }
    }
}