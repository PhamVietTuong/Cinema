namespace Cinema.Data.Models
{
    public class AgeRestriction
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Abbreviation { get; set; }
        public bool Status { get; set; }
    }
}
