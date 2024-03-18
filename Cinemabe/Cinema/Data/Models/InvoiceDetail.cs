namespace Cinema.Data.Models
{
    public class InvoiceDetail
    {
        public int Id { get; set; }

        public int InvoiceId { get; set; }
        public Invoice Invoice { get; set; }

        public int FoodAndDrinkId { get; set; }
        public FoodAndDrink FoodAndDrink { get; set; }
        public int Quantity { get; set; }
        public double Price { get; set; }
        public bool Status { get; set; }
    }
}
