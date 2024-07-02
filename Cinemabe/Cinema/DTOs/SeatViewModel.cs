using Cinema.Data.Models;

namespace Cinema.DTOs
{
	public class SeatViewModel
	{
        public string RoomName { get; set; }
        public List<RowNameViewModel> RowName { get; set; }
    }
}
