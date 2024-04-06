using Cinema.Data.Models;

namespace Cinema.DTOs
{
	public class TicketBookingViewModel
	{
		public Guid ShowTimeId { get; set; }
		public List<Chair> ListChair { get; set;}
	}
}
