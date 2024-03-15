using Microsoft.AspNetCore.Identity;

namespace Cinema.Data.Models
{
    public class User : IdentityUser
    {
        public string Name { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public DateTime BirthDay { get; set; }
        public bool Gender { get; set; }
        public bool Status { get; set; }
    }
}
