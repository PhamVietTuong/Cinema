using System.ComponentModel.DataAnnotations.Schema;

namespace Cinema.Data.Models
{
    public class Comment
    {
        public Guid Id { get; set; }
        public Guid MovieId { get; set; }
        public Movie Movie { get; set; }
        public string Phone { get; set; }
        public string Content { get; set; }
        public bool Status { get; set; }

        public DateTime CreatedDate { get; set; }
        public Guid? ParentId { get; set; }
        public Comment Parent { get; set; }
        public ICollection<Comment> Replies { get; set; }
        [ForeignKey("Phone")]
        public User User { get; set; }
    }
}