namespace Cinema.Data.Models
{
    public class MemberShip
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int Value { get; set; }
        public int Status { get; set; }
    }
}