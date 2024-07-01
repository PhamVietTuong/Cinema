using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using Cinema.DTOs;
using System.Collections.Generic;
using Cinema.Helper;
using System.Net;

[ApiController]
[Route("api/[controller]")]
public class PaymentsController : ControllerBase
{
    private readonly IConfiguration _configuration;

    public PaymentsController(IConfiguration configuration)
    {
        _configuration = configuration;
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
    { "vnp_ExpireDate", DateTime.Now.AddMinutes(15).ToString("yyyyMMddHHmmss") },
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
    public IActionResult VNPayReturn()
    {
        var vnpParams = new Dictionary<string, string>();

        foreach (var key in Request.Query.Keys)
        {
            vnpParams[key] = Request.Query[key];
        }

        var hashSecret = _configuration["VNPay:HashSecret"];
        var rspCode = "00"; // Mặc định là "thành công"
        var message = "Payment success";

        try
        {
            if (!vnpParams.TryGetValue("vnp_SecureHash", out var vnp_SecureHash))
            {
                rspCode = "97"; // Mã lỗi: Chữ ký không hợp lệ
                message = "Missing signature";
            }
            else
            {
                vnpParams.Remove("vnp_SecureHash");

                var sortedVnpParams = new SortedList<string, string>(vnpParams);
                var signData = string.Join("&", sortedVnpParams.Select(kv => $"{WebUtility.UrlEncode(kv.Key)}={WebUtility.UrlEncode(kv.Value)}"));
                var computedHash = VnPayHelper.ComputeHmacSha512Hash(hashSecret, signData);

                if (vnp_SecureHash != computedHash)
                {
                    rspCode = "97"; // Mã lỗi: Chữ ký không hợp lệ
                    message = "Invalid signature";
                }
                else
                {
                    // Kiểm tra các thông tin khác như số tiền, mã đơn hàng, trạng thái giao dịch, v.v.
                    // Cập nhật kết quả giao dịch vào cơ sở dữ liệu của bạn tại đây
                }
            }
        }
        catch (Exception ex)
        {
            rspCode = "99"; // Mã lỗi: Lỗi không xác định
            message = "Unknown error: " + ex.Message;
        }

        var response = new Dictionary<string, string>
        {
            { "RspCode", rspCode },
            { "Message", message }
        };

        return Ok(response);
    }
}
