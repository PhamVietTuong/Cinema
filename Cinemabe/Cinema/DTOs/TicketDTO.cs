using Cinema.Data.Models;
using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.DTOs
{
	public class TicketDTO
	{
		public Guid Id { get; set; }
        public Guid ShowTimeId { get; set; }
        public Guid UserId { get; set; }
		public Guid SeatId { get; set; }
	}
}
