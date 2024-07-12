using Microsoft.AspNetCore.Identity;
using System.Text.Json.Serialization;

namespace Cinema.Data.Models
{
    public class User
    {
        public Guid UserTypeId { get; set; }
        public UserType UserType { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public DateTime BirthDay { get; set; }
		[JsonIgnore]
		public string PasswordHash { get; set; }
		[JsonIgnore]
		public string PasswordSalt { get; set; }
		public bool Gender { get; set; }
        [JsonIgnore]
        public bool Status { get; set; }
        public Guid MemberShipId { get; set; }
        public MemberShip MemberShip { get; set; }
    }
}
