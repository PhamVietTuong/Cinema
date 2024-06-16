using Cinema.DTOs;
using System.Security.Cryptography;

namespace Cinema.Helper
{
	public class PasswordUtils
	{
		public static PasswordHashSalt EncryptPassword(string password)
		{
			var saltBytes = new byte[60];
			var provider = new RNGCryptoServiceProvider();
			provider.GetNonZeroBytes(saltBytes);
			var salt = Convert.ToBase64String(saltBytes);

			var rfc2898DeriveBytes = new Rfc2898DeriveBytes(password, saltBytes, 10000);
			var hashPassword = Convert.ToBase64String(rfc2898DeriveBytes.GetBytes(256));

			PasswordHashSalt hashSalt = new PasswordHashSalt { Hash = hashPassword, Salt = salt };
			return hashSalt;
		}

        public static bool ValidatePassword(string password, PasswordHashSalt hashSalt)
        {
            var saltBytes = Convert.FromBase64String(hashSalt.Salt);
            var rfc2898DeriveBytes = new Rfc2898DeriveBytes(password, saltBytes, 10000);
            return Convert.ToBase64String(rfc2898DeriveBytes.GetBytes(256)) == hashSalt.Hash;
        }
    }
}
