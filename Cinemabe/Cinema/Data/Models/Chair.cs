namespace Cinema.Data.Models
{
    public class Chair
    {
        public Guid Id { get; set; }
        public Guid ChairTypeId { get; set; }
        public ChairType ChairType { get; set; }
        public Guid RowChairId { get; set; }
        public RowChair RowChair { get; set; }
        public Guid RoomId { get; set; }
        public Room Room { get; set; }
        public string Name { get; set; }
		public bool IsSold { get; set; }    
    }
}
