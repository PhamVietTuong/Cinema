namespace Cinema.Data.Models
{
    public class FoodAndDrinkTheater
    {
        public Guid FoodAndDrinkId { get; set; }
        public Guid TheaterId { get; set; }
        public double Price { get; set; }

        public FoodAndDrink FoodAndDrink { get; set; }
        public Theater Theater { get; set; }
    }
}
