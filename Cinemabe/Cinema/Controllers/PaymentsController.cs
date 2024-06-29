using Microsoft.AspNetCore.Mvc;
using Cinema.DTOs;
using Cinema.Helper;
using Cinema.Contracts;
using Newtonsoft.Json;
using System.Text;
namespace Cinema.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IMomoRepository _momoRepository;
        private readonly IInvoiceRepository _invoiceRepository;

        public PaymentsController(IConfiguration configuration, IMomoRepository momoRepository, IInvoiceRepository invoiceRepository)
        {
            _configuration = configuration;
            _momoRepository = momoRepository;
            _invoiceRepository = invoiceRepository;
        }

        [HttpPost("VNPayCreatePayment")]
        public IActionResult CreatePayment(PaymentRequest request)
        {
            var tmnCode = _configuration["VNPay:TmnCode"];
            var hashSecret = _configuration["VNPay:HashSecret"];
            var vnpUrl = _configuration["VNPay:VnpUrl"];
            var returnUrl = request.ReturnUrl ?? _configuration["VNPay:ReturnUrl"];
            var tick = DateTime.Now.Ticks.ToString();
            var vnp_Params = new SortedList<string, string>
{
    { "vnp_Amount", ((int)(request.Amount * 100)).ToString() },
    { "vnp_Command", "pay" },
    { "vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss") },
    { "vnp_CurrCode", "VND" },
    { "vnp_ExpireDate", DateTime.Now.AddMinutes(15).ToString("yyyyMMddHHmmss") },
    { "vnp_IpAddr", VnPayHelper.GetClientIpAddress(Request.HttpContext) },
    { "vnp_Locale", "vn" },
    { "vnp_OrderInfo", request.OrderInfo },
    { "vnp_OrderType", "other" },
    { "vnp_ReturnUrl", returnUrl },
    { "vnp_TmnCode", tmnCode },
    { "vnp_TxnRef", tick },
    { "vnp_Version", "2.1.0" }
};


            var paymentUrl = VnPayHelper.CreateRequestUrl(vnpUrl, hashSecret, vnp_Params);
            return Ok(new PaymentResponse { PaymentUrl = paymentUrl });
        }

        [HttpPost("CreateLinkCheckoutMomo")]
        public async Task<IActionResult> CreateLinkCheckoutMomo([FromBody] PaymentRequest paymentRequest)
        {
            try
            {
                (bool isSuccess, string message) = await _momoRepository.CreatePaymentAsync(paymentRequest);
                if (isSuccess)
                {
                    return Ok(new { paymentUrl = message });
                }
                else
                {
                    return BadRequest(new { error = message });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { error = ex.Message });
            }
        }

        [HttpGet("MomoIpn")]
        public async Task<IActionResult> MomoIpn([FromQuery] MomoOneTimePaymentResultRequest ipnRequest)
        {
            try
            {
                if (!ipnRequest.IsValidSignature(_configuration["MoMo:AccessKey"], _configuration["MoMo:SecretKey"]))
                {
                    return BadRequest(new { error = "Invalid signature" });
                }

                bool isUpdated = await _invoiceRepository.UpdateCodeStatusAsync(ipnRequest.OrderId, ipnRequest.ResultCode);

                if (isUpdated)
                {
                    var movieInfo = await _invoiceRepository.GetInvoiceAsync(ipnRequest.OrderId);

                    if (movieInfo != null)
                    {
                        var resultData = new
                        {
                            barcode = ipnRequest.OrderId,
                            payment = ipnRequest.PayType,
                            movieInfo
                        };
                        var resultJson = JsonConvert.SerializeObject(resultData);
                        var bytes = Encoding.UTF8.GetBytes(resultJson); 
                        var base64Result = Convert.ToBase64String(bytes);

                        var customUrl = $"http://localhost:3000/checkout/info?result={base64Result}";
                        return Redirect(customUrl);
                    }
                    else
                    {
                        return BadRequest(new { error = "Failed to retrieve movie information" });
                    }
                }
                else
                {
                    return BadRequest(new { error = "Failed to update order status" });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { error = ex.Message });
            }
        }
    }
}
