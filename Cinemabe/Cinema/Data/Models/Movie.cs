namespace Cinema.Data.Models
{
    public class Movie
    {
        public Guid Id { get; set; }
		public Guid AgeRestrictionId { get; set; }
		public AgeRestriction AgeRestriction { get; set; }
        public Guid ShowTimeTypeId { get; set; }
        public ShowTimeType ShowTimeType { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public int Time { get; set; }
        public DateTime ReleaseDate { get; set; }
        public string Description { get; set; }
        public string Director { get; set; }
        public string Actor { get; set; }
        public string Trailer { get; set; }
        public string Languages { get; set; }
        public bool Status { get; set; }
    }
}
