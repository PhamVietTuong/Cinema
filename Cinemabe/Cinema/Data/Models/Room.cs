namespace Cinema.Data.Models
{
    public class Room
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
		public double With { get; set; }
		public double Length { get; set; }
		public bool Status { get; set; }
    }
}
