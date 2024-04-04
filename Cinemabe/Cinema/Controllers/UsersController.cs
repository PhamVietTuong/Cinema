using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Cinema.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class UsersController : ControllerBase
	{
		private readonly IUnitOfWork _uow;

		public UsersController(
			IUnitOfWork uow
			)
		{
			_uow = uow;
		}

		[HttpPost]
		[Route("register")]
		public async Task<IActionResult> Register(RegisterViewModel re)
		{

			return await _uow.UserRepository.Register(re);
		}
	}
}
