namespace Cinema.DTOs
{
    public class PaymentRequest
    {
        public decimal Amount { get; set; }
        public string OrderInfo { get; set; }
        public string OrderId { get; set; }
    }

    public class PaymentResponse
    {
        public string PaymentUrl { get; set; }
    }

}