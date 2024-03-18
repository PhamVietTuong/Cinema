namespace Cinema.Data.Models
{
    public class Room
    {
        public int Id { get; set; }

        public int TheaterId { get; set; }
        public Theater Theater { get; set; }

		public string Name { get; set; }

		public double With { get; set; }

		public double Length { get; set; }

		public bool Status { get; set; }
    }
}
