using Cinema.Data;
using Cinema.Data.Models;
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
		private readonly CinemaContext _context;
		private readonly UserManager<User> _userManager;
		private readonly RoleManager<IdentityRole> _roleManager;
		private readonly IConfiguration _configuration;

		public UsersController(
			CinemaContext context,
			UserManager<User> userManager,
			RoleManager<IdentityRole> roleManager,
			IConfiguration configuration
			)
		{
			_context = context;
			_userManager = userManager;
			_roleManager = roleManager;
			_configuration = configuration;
		}
	}
}
