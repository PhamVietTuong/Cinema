namespace Cinema.DTOs
{
	public class InvoiceDTO
	{
        public InvoiceDTO()
        {
            InvoiceTickets = new List<InvoiceTicketDTO>();
            FoodAndDrinks = new List<InvoiceFoodAndDrinkDTO>();
        }
        public Guid UserId { get; set; }
        public Guid RoomId { get; set; }
        public Guid ShowTimeId { get; set; }
        public Guid TheaterId { get; set; }
        public string OrderInfo { get; set; }
        public List<InvoiceTicketDTO> InvoiceTickets { get; set; }
        public List<InvoiceFoodAndDrinkDTO> FoodAndDrinks { get; set; }
    }
}
