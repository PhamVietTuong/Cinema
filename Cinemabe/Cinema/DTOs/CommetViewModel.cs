using System.ComponentModel.DataAnnotations.Schema;
using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class CommentViewModel
    {
        public Guid Id { get; set; }
        public string UserName { get; set; }
        public string Content { get; set; }
        public DateTime CreatedDate { get; set; }
        public ICollection<CommentViewModel> Replies { get; set; }
    }
}