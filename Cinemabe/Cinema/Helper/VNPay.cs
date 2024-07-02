using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Http;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Globalization;
namespace Cinema.Helper
{
    public static class VnPayHelper
    {
        public static string CreateRequestUrl(string baseUrl, string vnpHashSecret, SortedList<string, string> vnpParams)
        {
            var queryString = string.Join("&", vnpParams.Select(kv => $"{WebUtility.UrlEncode(kv.Key)}={WebUtility.UrlEncode(kv.Value)}"));
            var signData = queryString;
            var secureHash = ComputeHmacSha512Hash(vnpHashSecret, signData);

            return $"{baseUrl}?{queryString}&vnp_SecureHash={secureHash}";
        }

        public static string ComputeHmacSha512Hash(string key, string inputData)
        {
            var hash = new StringBuilder();
            byte[] keyBytes = Encoding.UTF8.GetBytes(key);
            byte[] inputBytes = Encoding.UTF8.GetBytes(inputData);
            using (var hmac = new HMACSHA512(keyBytes))
            {
                byte[] hashValue = hmac.ComputeHash(inputBytes);
                foreach (var theByte in hashValue)
                {
                    hash.Append(theByte.ToString("x2"));
                }
            }

            return hash.ToString();
        }

        public static string GetClientIpAddress(HttpContext httpContext)
        {
            var remoteIpAddress = httpContext.Connection.RemoteIpAddress;

            if (remoteIpAddress != null && remoteIpAddress.AddressFamily == AddressFamily.InterNetworkV6)
            {
                remoteIpAddress = GetFirstIpV4Address(Dns.GetHostEntry(remoteIpAddress).AddressList);
            }

            return remoteIpAddress?.ToString() ?? "127.0.0.1";
        }

        private static IPAddress GetFirstIpV4Address(IPAddress[] addresses)
        {
            return addresses.FirstOrDefault(ip => ip.AddressFamily == AddressFamily.InterNetwork);
        }

        
    }

    
}