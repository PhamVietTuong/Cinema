using Microsoft.Extensions.Configuration.UserSecrets;

namespace Cinema.Helper
{
    public class MomoOneTimePaymentResultRequest
    {
        public string? PartnerCode { get; set; }
        public string? RequestId { get; set; }
        public string? OrderId { get; set; }
        public string? OrderInfo { get; set; }
        public long Amount { get; set; }
        public string? TransId { get; set; }
        public string? Message { get; set; }
        public long ResponseTime { get; set; }
        public string? ExtraData { get; set; }
        public int ResultCode { get; set; }
        public string? Signature { get; set; }
        public string? OrderType { get; set; }
        public string? PayType { get; set; }

        public bool IsValidSignature(string accessKey, string secretKey)
        {
            var rawHash = "accessKey=" + accessKey +
                   "&amount=" + this.Amount +
                   "&extraData=" + this.ExtraData +
                   "&message=" + this.Message +
                   "&orderId=" + this.OrderId +
                   "&orderInfo=" + this.OrderInfo +
                   "&orderType=" + this.OrderType +
                   "&partnerCode=" + this.PartnerCode +
                   "&payType=" + this.PayType +
                   "&requestId=" + this.RequestId +
                   "&responseTime=" + this.ResponseTime +
                   "&resultCode=" + this.ResultCode +
                   "&transId=" + this.TransId;
            var checkSignature = MoMoSecurity.signSHA256(rawHash, secretKey);
            return this.Signature.Equals(checkSignature);
        }
    }
}
