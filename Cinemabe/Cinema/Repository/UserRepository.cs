using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Repository
{
	public class UserRepository : IUserRepository
	{
		private readonly CinemaContext _context;
		private readonly UserManager<User> _userManager;
		private readonly RoleManager<IdentityRole> _roleManager;

		public UserRepository(CinemaContext context, 
						UserManager<User> userManager,
						 RoleManager<IdentityRole> roleManager
		)
        {
            _context = context;
			_userManager = userManager;
			_roleManager = roleManager;
        }

		public CinemaContext Context { get; }

		public async Task<IActionResult> Register(RegisterViewModel vm)
		{
			var userExists = await _userManager.FindByNameAsync(vm.UserName);
			if (userExists != null)
			{
				var error = new { Message = "User already exists" };
				return new BadRequestObjectResult(error);
			}

			User user = new User()
			{
				Email = vm.Email,
				SecurityStamp = Guid.NewGuid().ToString(),
				UserName = vm.UserName,
				Status = true

			};

			var result = await _userManager.CreateAsync(user, vm.PassWord);

			if (!result.Succeeded)
			{
				var errorResponse = new { Message = "Something went wrong!" };
				return new BadRequestObjectResult(errorResponse);
			}
			if (!await _roleManager.RoleExistsAsync("Admin"))
			{
				await _roleManager.CreateAsync(new IdentityRole("Admin"));

			}
			if (!await _roleManager.RoleExistsAsync("User"))
			{
				await _roleManager.CreateAsync(new IdentityRole("User"));

			}
			if (await _roleManager.RoleExistsAsync("User"))
			{
				await _userManager.AddToRoleAsync(user, "User");
			}
			return new OkResult();
		}
	}
}
