using System.Text.Json.Serialization;

namespace Cinema.DTOs
{
	public class Register
	{
		public string UserName { get; set; }
		[JsonIgnore]
		public string PasswordHash { get; set; }
		[JsonIgnore]
		public string PasswordSalt { get; set; }
		public string Email { get; set; }
		public string FullName { get; set; }
		public bool Status { get; set; }
	}
}
