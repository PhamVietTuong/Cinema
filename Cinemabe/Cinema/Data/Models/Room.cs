namespace Cinema.Data.Models
{
    public class Room
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public int TheaterId { get; set; }
        public Theater Theater { get; set; }

        public bool Status { get; set; }
    }
}
