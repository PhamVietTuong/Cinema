using Cinema.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Contracts
{
	public interface IUserRepository
	{
		Task<IActionResult> Register(RegisterViewModel model); 
	}
}
