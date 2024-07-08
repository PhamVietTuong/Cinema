using Microsoft.AspNetCore.Mvc;
using Cinema.DTOs;
using Cinema.Helper;
using System.Net;
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
            var returnUrl = _configuration["VNPay:ReturnUrl"];
            var vnp_Params = new SortedList<string, string>
{
    { "vnp_Amount", ((int)(request.Amount * 100)).ToString() },
    { "vnp_Command", "pay" },
    { "vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss") },
    { "vnp_CurrCode", "VND" },
    { "vnp_ExpireDate", DateTime.Now.AddMinutes(5).ToString("yyyyMMddHHmmss") },
    { "vnp_IpAddr", VnPayHelper.GetClientIpAddress(Request.HttpContext) },
    { "vnp_Locale", "vn" },
    { "vnp_OrderInfo", request.OrderInfo },
    { "vnp_OrderType", "other" },
    { "vnp_ReturnUrl", returnUrl },
    { "vnp_TmnCode", tmnCode },
    { "vnp_TxnRef", request.OrderId },
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
                    var resultCode = ipnRequest.ResultCode;
                    var message = ipnRequest.Message;
                    if (ipnRequest.OrderInfo.Contains("web"))
                    {
                        var movieInfo = default(InvoiceViewModel);

                        if (resultCode == 0)
                        {
                            movieInfo = await _invoiceRepository.GetInvoiceAsync(ipnRequest.OrderId);
                        }

                        var resultData = new
                        {
                            barcode = ipnRequest.OrderId,
                            resultCode,
                            movieInfo
                        };
                        var resultJson = JsonConvert.SerializeObject(resultData);
                        var bytes = Encoding.UTF8.GetBytes(resultJson);
                        var base64Result = Convert.ToBase64String(bytes);

                        var customUrl = $"http://localhost:3000/checkout/info?result={base64Result}";
                        return Redirect(customUrl);
                    }
                    else if (ipnRequest.OrderInfo.Contains("app"))
                    {
                        var response = new Dictionary<string, string>
                        {
                            { "RspCode", resultCode.ToString() },
                            { "Message", message }
                        };
                        return Ok(response);
                    }
                }
                else
                {
                    return BadRequest(new { error = "Failed to update order status" });
                }

                return BadRequest(new { error = "Unhandled case" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { error = ex.Message });
            }
        }

        // [HttpPost("VNPayIPN")]
        // public IActionResult VNPayIPN(Dictionary<string, string> vnpParams)
        // {
        //     var secretKey = _configuration["VNPay:HashSecret"];
        //     var responseData = new Dictionary<string, string>
        //     {
        //         { "RspCode", "00" }, // Default is "success"
        //         { "Message", "Confirm Success" }
        //     };

        //     try
        //     {
        //         var secureHash = vnpParams["vnp_SecureHash"];
        //         vnpParams.Remove("vnp_SecureHash");

        //         var sortedVnpParams = new SortedList<string, string>(vnpParams);
        //         var signData = string.Join("&", sortedVnpParams.Select(kv => $"{WebUtility.UrlEncode(kv.Key)}={WebUtility.UrlEncode(kv.Value)}"));
        //         var computedHash = VnPayHelper.ComputeHmacSha512Hash(secretKey, signData);

        //         if (secureHash != computedHash)
        //         {
        //             responseData["RspCode"] = "97"; // Error code for invalid signature
        //             responseData["Message"] = "Invalid signature";
        //         }
        //         else
        //         {
        //             // Verify other payment information such as amount, order ID, transaction status, etc.
        //             // Update the payment result to your database here
        //         }
        //     }
        //     catch (Exception ex)
        //     {
        //         responseData["RspCode"] = "99"; // Error code for unknown error
        //         responseData["Message"] = "Unknown error: " + ex.Message;
        //     }

        //     return Ok(responseData);
        // }
        [HttpGet("VNPayReturn")]
        public async Task<IActionResult> VNPayReturnAsync()
        {
            var vnpParams = new Dictionary<string, string>(Request.Query.ToDictionary(x => x.Key, x => x.Value.ToString()));
            var hashSecret = _configuration["VNPay:HashSecret"];
            var responseCode = vnpParams["vnp_ResponseCode"];
            var message = "Payment success";
            var application = vnpParams["vnp_OrderInfo"];

            try
            {
                if (!vnpParams.TryGetValue("vnp_SecureHash", out var secureHash))
                {
                    responseCode = "97"; // Error code for invalid signature
                    message = "Missing signature";
                }
                else
                {
                    vnpParams.Remove("vnp_SecureHash");

                    var sortedVnpParams = new SortedList<string, string>(vnpParams);
                    var signData = string.Join("&", sortedVnpParams.Select(kv => $"{WebUtility.UrlEncode(kv.Key)}={WebUtility.UrlEncode(kv.Value)}"));
                    var computedHash = VnPayHelper.ComputeHmacSha512Hash(hashSecret, signData);

                    if (secureHash != computedHash)
                    {
                        responseCode = "97"; // Error code for invalid signature
                        message = "Invalid signature";
                    }
                }
            }
            catch (Exception ex)
            {
                responseCode = "99"; // Error code for unknown error
                message = "Unknown error: " + ex.Message;
            }

            if (responseCode == "24")
            {
                message = "Payment failed because user canceled";
            }
            bool isUpdated = await _invoiceRepository.UpdateCodeStatusAsync(vnpParams["vnp_TxnRef"], Int32.Parse(responseCode));

            var response = new Dictionary<string, string>
            {
                { "RspCode", responseCode },
                { "Message", message }
            };

            if (application.Contains("web"))
            {
                var movieInfo = default(InvoiceViewModel);

                if (responseCode == "00")
                {
                    movieInfo = await _invoiceRepository.GetInvoiceAsync(vnpParams["vnp_TxnRef"]);
                }

                if (movieInfo != null)
                {
                    var resultData = new
                    {
                        barcode = vnpParams["vnp_TxnRef"],
                        resultCode = responseCode,
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
            else if (application.Contains("app"))
            {
                return Ok(response);
            }

            return Ok(response);
        }
    }
}
