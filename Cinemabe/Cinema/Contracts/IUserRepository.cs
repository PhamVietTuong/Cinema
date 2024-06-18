using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Contracts
{
	public interface IUserRepository
	{
		Task<User> CreateAsync(User entity); 
		Task<string> SendAuthenticationCode(string email);
	}
}
