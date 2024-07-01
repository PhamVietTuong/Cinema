using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface IMomoRepository
    {
        public Task<(bool isSuccess, string message)> CreatePaymentAsync(PaymentRequest paymentRequest);
    }
}
