namespace Cinema.Data.Models
{
    public class Movie
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Time { get; set; }
        public int AgeRestrictionId { get; set; }
        public AgeRestriction AgeRestriction { get; set; }
        public DateTime ReleaseDate { get; set; }
        public string Description { get; set; }
        public string Director { get; set; }
        public string Actor { get; set; }
        public string Trailer { get; set; }
        public string Languages { get; set; }
        public bool Status { get; set; }
    }
}
