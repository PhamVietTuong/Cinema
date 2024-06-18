using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface IInvoiceRepository
    {
        Task<InvoiceViewModel> GetInvoiceAsync(string code);
    }
}
