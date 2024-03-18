namespace Cinema.Data.Models
{
    public class Chair
    {
        public int Id { get; set; }

        public int ChairTypeId { get; set; }
        public ChairType ChairType { get; set; }

		//public int RoomId { get; set; }
		//public Room Room { get; set; }  
		//public int TheaterId { get; set; }
		//public Theater Theater { get; set; }

		public string ChairNumber { get; set; }

		public bool Status { get; set; }    
    }
}
