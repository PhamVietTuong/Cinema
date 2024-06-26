using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.Security.Cryptography;
using System.Text;

namespace Cinema.Helper
{
    public static class MoMoSecurity
    {
        public static string signSHA256(string message, string key)
        {
            byte[] keyByte = Encoding.UTF8.GetBytes(key);
            byte[] messageBytes = Encoding.UTF8.GetBytes(message);
            using (var hmacsha256 = new HMACSHA256(keyByte))
            {
                byte[] hashmessage = hmacsha256.ComputeHash(messageBytes);
                string hex = BitConverter.ToString(hashmessage);
                hex = hex.Replace("-", "").ToLower();
                return hex;

            }
        }

        public static async Task<(bool, string?)> GetLinkAsync(string paymentUrl, object message)
        {
            using HttpClient client = new HttpClient();
            var requestData = JsonConvert.SerializeObject(message, new JsonSerializerSettings()
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver(),
                Formatting = Formatting.Indented,
            });
            var requestContent = new StringContent(requestData, Encoding.UTF8, "application/json");

            var createPaymentLinkRes = await client.PostAsync(paymentUrl, requestContent);

            if (createPaymentLinkRes.IsSuccessStatusCode)
            {
                var responseContent = await createPaymentLinkRes.Content.ReadAsStringAsync();
                var responseData = JsonConvert.DeserializeObject<MomoOneTimePaymentCreateLinkResponse>(responseContent);
                if (responseData.ResultCode == "0")
                {
                    return (true, responseData.PayUrl);
                }
                else
                {
                    return (false, responseData.Message);
                }
            }
            else
            {
                var errorContent = await createPaymentLinkRes.Content.ReadAsStringAsync();
                return (false, $"Error: {createPaymentLinkRes.ReasonPhrase}, Content: {errorContent}");
            }
        }
    }
}
