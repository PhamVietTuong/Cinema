using System.Text.Json.Serialization;

namespace Cinema.DTOs
{
	public class Register
	{
		public String UserTypeName { get; set; }
		public string FullName { get; set; }
		public string Email { get; set; }
		public string Phone { get; set; }
		public DateTime BirthDay { get; set; }
		public string Password { get; set; }
		public string ConfirmPassword { get; set; }
		public bool Gender { get; set; }
		[JsonIgnore]
		public bool Status { get; set; }
	}
}
