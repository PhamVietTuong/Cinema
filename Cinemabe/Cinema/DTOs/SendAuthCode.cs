namespace Cinema.DTOs
{
    public class RequestSendAuthCode
    {
        public string Email { get; set; }
    }
    public class ResultSendCode{
        public string Message { get; set; }
        public bool IsSuccess { get; set; }
    }
}
