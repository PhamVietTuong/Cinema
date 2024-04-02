using Cinema.Data.Models;

namespace Cinema.DTOs
{
	public class TicketBookingViewModel
	{
		public int ShowTimeId { get; set; }
		public List<Chair> ListChair { get; set;}
	}
}
