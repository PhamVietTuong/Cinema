using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using Cinema.DTOs;
using System.Collections.Generic;
using Cinema.Helper;
using Cinema.Contracts;
namespace Cinema.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IMomoRepository _momoRepository;

        public PaymentsController(IConfiguration configuration, IMomoRepository momoRepository)
        {
            _configuration = configuration;
            _momoRepository = momoRepository;
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
                var response = await _momoRepository.CreatePaymentAsync(paymentRequest);
                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
