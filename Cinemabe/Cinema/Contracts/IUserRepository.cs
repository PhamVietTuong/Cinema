using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Contracts
{
	public interface IUserRepository
	{
		Task<User> CreateAsync(User entity);
        Task<TokenInfo> GenerateToken(string userIdentifier, string userType = null);
        Task<User> ValidateLogin(string identifier, string password, string userType = null);
    }
}
