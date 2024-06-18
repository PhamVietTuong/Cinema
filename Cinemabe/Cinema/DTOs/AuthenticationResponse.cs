using Cinema.Data.Models;

namespace Cinema.DTOs
{
    public class AuthenticationResponse
    {
        public Guid Id { get; set; }
        public string FullName { get; set; }
        public string UserName { get; set; }
        public string Type { get; set; }
        public string Token { get; set; }
        public DateTime ExpirationTime { get; set; }

        public AuthenticationResponse(User user, string userName, string type, string token, DateTime expirationTime)
        {
            Id = user.Id;
            FullName = user.FullName;
            UserName = userName;
            Type = type;
            Token = token;
            ExpirationTime = expirationTime;
        }
    }
}
