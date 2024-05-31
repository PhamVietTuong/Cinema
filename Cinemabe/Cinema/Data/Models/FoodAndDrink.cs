namespace Cinema.Data.Models
{
    public class FoodAndDrink
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }
        public double Price { get; set; }
        public Guid TheaterId { get; set; }
        public Theater Theater { get; set; }
        public bool Status { get; set; }
    }
}
