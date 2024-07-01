using Cinema.Contracts;
using Cinema.DTOs;
using Cinema.Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Text;

namespace Cinema.Repository
{
    public class MomoRepository : IMomoRepository
    {
        private readonly string partnerCode;
        private readonly string accessKey;
        private readonly string secretKey;
        private readonly string redirectUrl;
        private readonly string ipnUrl;
        private readonly string endpoint;

        public MomoRepository(IConfiguration configuration)
        {
            partnerCode = configuration["MoMo:PartnerCode"];
            accessKey = configuration["MoMo:AccessKey"];
            secretKey = configuration["MoMo:SecretKey"];
            redirectUrl = configuration["MoMo:ReturnUrl"];
            ipnUrl = configuration["MoMo:IpnUrl"];
            endpoint = configuration["MoMo:Endpoint"];
        }

        public async Task<(bool isSuccess, string message)> CreatePaymentAsync(PaymentRequest paymentRequest)
        {
            string orderId = paymentRequest.OrderId;
            string requestId = Guid.NewGuid().ToString();
            string amount = paymentRequest.Amount.ToString();
            string orderInfo = "CKC";
            string extraData = string.Empty;
            string requestType = "captureWallet";
            string lang = "vi";

            var rawHash = "accessKey=" + accessKey +
                "&amount=" + amount +
                "&extraData=" + extraData +
                "&ipnUrl=" + ipnUrl +
                "&orderId=" + orderId +
                "&orderInfo=" + orderInfo +
                "&partnerCode=" + partnerCode +
                "&redirectUrl=" + redirectUrl +
                "&requestId=" + requestId +
                "&requestType=" + requestType;

            string signature = MoMoSecurity.signSHA256(rawHash, secretKey);

            var message = new
            {
                partnerCode,
                accessKey,
                requestId,
                amount,
                orderId,
                orderInfo,
                redirectUrl,
                ipnUrl,
                extraData,
                requestType,
                lang,
                signature
            };

            (bool createMomoLinkResult, string? createMessage) = await MoMoSecurity.GetLinkAsync(endpoint, message);
            if (createMomoLinkResult)
            {
                return (true, createMessage);
            }
            else
            {
                return (false, createMessage);
            }
        }
    }
}
