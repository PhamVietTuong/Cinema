namespace Cinema.Data.Models
{
    public class Chair
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public int ChairTypeId { get; set; }
        public ChairType ChairType { get; set; }

        //public int RoomId { get; set; }
        //public Room Room { get; set; }  

        public bool Status { get; set; }    
    }
}
