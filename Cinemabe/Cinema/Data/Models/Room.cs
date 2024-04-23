namespace Cinema.Data.Models
{
    public class Room
    {
        public Guid Id { get; set; }
        public Guid TheaterId { get; set; }
        public Theater Theater { get; set; }
        public string Name { get; set; }
		public double Width { get; set; }
		public double Length { get; set; }
		public bool Status { get; set; }
    }
}
