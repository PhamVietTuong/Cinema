using Cinema.Data.Models;
using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.DTOs
{
	public class BookingDTO
	{
		public Guid Id { get; set; }
        public Guid ShowTimeId { get; set; }
        public Guid UserId { get; set; }
		public List<Guid> SeatIds { get; set; }
		public List<InvoiceComboDTO> FoodAndDrinkIds { get; set; }
	}
}
