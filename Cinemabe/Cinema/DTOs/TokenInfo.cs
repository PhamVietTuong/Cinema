namespace Cinema.DTOs
{
    public class TokenInfo
    {
        public string UserName { get; set; }
        public string Token { get; set; }
        public string Authority { get; set; }
        public DateTime ExpirationTime { get; set; }
    }
}
