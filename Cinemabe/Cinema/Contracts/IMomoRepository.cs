using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface IMomoRepository
    {
        Task<string> CreatePaymentAsync(PaymentRequest paymentRequest);
    }
}
