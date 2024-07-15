using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class AuthenticationResponse
    {
        public string FullName { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public DateTime BirthDay { get; set; }
        public bool Gender { get; set; }
        public string Type { get; set; }
        public string Token { get; set; }

        public AuthenticationResponse(User user, string type, string token)
        {
            FullName = user.FullName;
            Phone = user.Phone;
            Email = user.Email;
            BirthDay = user.BirthDay;
            Gender = user.Gender;
            Type = type;
            Token = token;
        }
    }
}
