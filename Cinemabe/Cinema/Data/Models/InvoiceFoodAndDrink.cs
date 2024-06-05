namespace Cinema.Data.Models
{
    public class InvoiceFoodAndDrink
    {
        public Guid InvoiceId { get; set; }
        public Guid FoodAndDrinkId { get; set; }
        public int Quantity { get; set; }
        public double Price { get; set; }

        public Invoice Invoice { get; set; }
        public FoodAndDrink FoodAndDrink { get; set; }
    }
}
