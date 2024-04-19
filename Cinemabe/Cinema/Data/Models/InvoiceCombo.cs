namespace Cinema.Data.Models
{
	public class InvoiceCombo
	{
		public Guid Id { get; set; }
		public Guid InvoiceId { get; set; }
		public Invoice Invoice { get; set; }
        public Guid FoodAndDrinkId { get; set; }
        public FoodAndDrink FoodAndDrink { get; set; }
        public int Quantity { get; set; }
	}
}
