using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Contracts
{

	public interface IUserRepository
	{
		Task<User> CreateAsync(User entity);
		Task<string> SendAuthenticationCode(string email);
        Task<TokenInfo> GenerateToken(string userIdentifier, string userType = null);
        Task<User> ValidateLogin(string identifier, string password, string userType = null);
		Task<bool> ChangePassword(string changePassword, string userName);
        Task<User> Register(Register register);
        Task<bool> ExistsAsync(Guid id);
        Task<UserDTO> UpdateAsync(UserDTO entity);
        Task<List<UserRowViewModel>> GetListUserAsync();
    }
}
