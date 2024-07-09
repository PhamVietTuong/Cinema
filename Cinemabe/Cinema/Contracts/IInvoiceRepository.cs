using Cinema.DTOs;

namespace Cinema.Contracts
{
    public interface IInvoiceRepository
    {
        Task<InvoiceViewModel> GetInvoiceAsync(string code);
        Task<bool> UpdateCodeStatusAsync(string orderId, int resultCode);
        Task<List<InvoiceViewModel>> InvoiceListOfUserAsync(Guid? userId);
        Task<List<RevenueTheaterViewModel>> GetRevenueAsync(FilterRevenue filterRevenue);
    }
}
