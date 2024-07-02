using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class RoomDTO
    {
        public RoomDTO()
        {
            RowName = new List<RowNameViewModel>();
            RowNameNew = new List<RowNameViewModel>();
        }
        public Guid Id { get; set; }
        public Guid TheaterId { get; set; }
        public string Name { get; set; }
        public bool Status { get; set; }
        public List<RowNameViewModel> RowName { get; set; }
        public List<RowNameViewModel> RowNameNew { get; set; }
    }
}
