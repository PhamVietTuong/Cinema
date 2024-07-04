using Cinema.Data.Models;
using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.DTOs
{
    public class TheaterDTO
    {
        public TheaterDTO()
        {
            Rooms = new List<RoomDTO>();
        }

        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Image { get; set; }
        public string Phone { get; set; }
        public int CountRoom { get; set; }
        public int CountSeat { get; set; }
        public bool Status { get; set; }
        public IFormFile File { get; set; }
        public List<RoomDTO> Rooms { get; set; }
    }
}
