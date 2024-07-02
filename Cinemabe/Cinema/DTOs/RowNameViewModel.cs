namespace Cinema.DTOs
{
    public class RowNameViewModel
    {
        public RowNameViewModel()
        {
            RowSeats = new List<RowSeatViewModel>();
            RowSeatsNew = new List<RowSeatViewModel>();
        }
        public string RowName { get; set; }
        public List<RowSeatViewModel> RowSeats { get; set; }
        public List<RowSeatViewModel> RowSeatsNew { get; set; }
    }
}
