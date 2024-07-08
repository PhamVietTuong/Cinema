using FirebaseAdmin;
using FirebaseAdmin.Auth;
using Google.Apis.Auth.OAuth2;

namespace Cinema.Helper
{
    public class Firebase
    {
        public Firebase()
        {
            // Đường dẫn tới tệp JSON chứa thông tin đăng nhập
            var pathToServiceAccountKey = Path.Combine(Directory.GetCurrentDirectory(), "Properties", "serviceAccountKey_phone.json");
            FirebaseApp.Create(new AppOptions()
            {
                Credential = GoogleCredential.FromFile(pathToServiceAccountKey),
            });
        }

        public async Task<string> SendVerificationCode(string phoneNumber)
        {
            try
            {
                // Gửi mã xác thực tới số điện thoại
               // var response = await FirebaseAuth.DefaultInstance.CreateSessionCookieAsync(phoneNumber);
                return "response";
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error sending verification code: " + ex.Message);
                return null;
            }
        }
    }
}