using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class InvoiceFoodAndDrink
    {
        public string Code { get; set; }
        public Guid FoodAndDrinkId { get; set; }
        public int Quantity { get; set; }
        public double Price { get; set; }

        [ForeignKey("Code")]
        public Invoice Invoice { get; set; }
        public FoodAndDrink FoodAndDrink { get; set; }
    }
}
