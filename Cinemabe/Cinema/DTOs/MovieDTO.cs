using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class MovieDTO
    {
        public Guid Id { get; set; }
        public Guid AgeRestrictionId { get; set; }
        public AgeRestriction AgeRestriction { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public int? Time2D { get; set; }
        public int? Time3D { get; set; }
        public DateTime ReleaseDate { get; set; }
        public string Description { get; set; }
        public string Director { get; set; }
        public string Actor { get; set; }
        public string Trailer { get; set; }
        public string Languages { get; set; }
        public bool Status { get; set; }
        public List<MovieTypeDTO> MovieTypes { get; set; }
        public IFormFile File { get; set; }
        public List<ShowTimeRoomDTO> ShowTimeRooms { get; set; }
    }
}