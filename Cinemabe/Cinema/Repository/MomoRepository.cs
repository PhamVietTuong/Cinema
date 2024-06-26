using Cinema.Contracts;
using Cinema.DTOs;
using Cinema.Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
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
            redirectUrl = configuration["MoMo:redirectUrl"];
            ipnUrl = configuration["MoMo:ipnUrl"];
            endpoint = configuration["MoMo:Endpoint"];
        }

        public async Task<string> CreatePaymentAsync(PaymentRequest paymentRequest)
        {
            string orderId = Guid.NewGuid().ToString();
            string requestId = Guid.NewGuid().ToString();
            string amount = paymentRequest.Amount.ToString();
            string orderInfo = paymentRequest.OrderInfo;
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
                return createMessage;
            }
            else
            {
                return createMessage;
            }
        }
    }
}
