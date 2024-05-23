namespace Cinema.Data.Models
{
    public class InvoiceDetail
    {
        public Guid Id { get; set; }
        public Guid TicketId { get; set; }
        public Ticket Ticket { get; set; }
        public Guid FoodAndDrinkId { get; set; }
        public FoodAndDrink FoodAndDrink { get; set; }
        public int Quantity { get; set; }
        public double Price { get; set; }
        public bool Status { get; set; }
    }
}
