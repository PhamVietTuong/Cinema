using Cinema.Data.Enum;
using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class InvoiceViewModel
    {
        public InvoiceViewModel()
        {
            FoodAndDrinks = new List<InvoiceFoodAndDrinkViewModel>();
        }

        public string MovieImage { get; set; }
        public string MovieName { get; set; }
        public string ProjectionFormText { get; set; }
        public string AgeRestrictionName { get; set; }
        public string AgeRestrictionDescription { get; set; }
        public string TheaterName { get; set; }
        public string Code { get; set; }
        public DateTime ShowTimeStartTime { get; set; }
        public string RoomName { get; set; }
        public int NumberTicket { get; set; }
        public string ShowTimeType { get; set; }
        public string SeatName { get; set; }
        public double TotalPrice { get; set; }
        public List<InvoiceFoodAndDrinkViewModel> FoodAndDrinks { get; set; }
    }
}
