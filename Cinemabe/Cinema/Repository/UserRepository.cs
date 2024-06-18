using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Cinema.Helper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
	public class UserRepository : IUserRepository
	{
		private readonly CinemaContext _context;

		public UserRepository(CinemaContext context)
		{
			_context = context;
		}


		public async Task<User> CreateAsync(User entity)
		{
			PasswordHashSalt passwordHashSalt = PasswordUtils.EncryptPassword(entity.PasswordHash);
			var userTypeExit = await _context.UserType.AnyAsync(x => x.Name == "User");

			var userTypes = await _context.UserType.ToListAsync();


			if (!userTypeExit)
			{
				var newUserTypes = new UserType
				{
					Name = "User",
				};

				await _context.AddAsync(newUserTypes);

				entity.UserTypeId = newUserTypes.Id;
				entity.PasswordHash = passwordHashSalt.Hash;
				entity.PasswordSalt = passwordHashSalt.Salt;
				await _context.AddAsync(entity);
			}
			else
			{
				entity.UserTypeId = userTypes.First(x => x.Name == "User").Id;
				entity.PasswordHash = passwordHashSalt.Hash;
				entity.PasswordSalt = passwordHashSalt.Salt;
				await _context.AddAsync(entity);
			}

			await _context.SaveChangesAsync();

			return entity;


			//if (!userTypeExit)
			//{
			//	var newUserTypes = new UserType
			//	{
			//		Name = "User",
			//	};

			//	await _context.AddAsync(newUserTypes);

			//	await _context.AddAsync(new User
			//	{
			//		UserTypeId = newUserTypes.Id,
			//		UserName = entity.UserName,
			//		FullName = entity.FullName,
			//		Email = entity.Email,
			//		PasswordHash = passwordHashSalt.Hash,
			//		PasswordSalt = passwordHashSalt.Salt,
			//		Status = true,
			//	});
			//}
			//else
			//{
			//	var existingUserType = await _context.UserType.FirstOrDefaultAsync(x => x.Name == "User");
			//	await _context.AddAsync(new User
			//	{
			//		UserTypeId = existingUserType.Id,
			//		UserName = entity.UserName,
			//		FullName = entity.FullName,
			//		Email = entity.Email,
			//		PasswordHash = passwordHashSalt.Hash,
			//		PasswordSalt = passwordHashSalt.Salt,
			//		Status = true,
			//	});
			//}
			//var userExists = await _userManager.FindByNameAsync(vm.UserName);
			//if (userExists != null)
			//{
			//	var error = new { Message = "User already exists" };
			//	return new BadRequestObjectResult(error);
			//}

			//User user = new User()
			//{
			//	Email = vm.Email,
			//	//SecurityStamp = Guid.NewGuid().ToString(),
			//	//UserName = vm.UserName,
			//	Status = true

			//};

			//var result = await _userManager.CreateAsync(user, vm.PassWord);

			//if (!result.Succeeded)
			//{
			//	var errorResponse = new { Message = "Something went wrong!" };
			//	return new BadRequestObjectResult(errorResponse);
			//}
			//if (!await _roleManager.RoleExistsAsync("Admin"))
			//{
			//	await _roleManager.CreateAsync(new IdentityRole("Admin"));

			//}
			//if (!await _roleManager.RoleExistsAsync("User"))
			//{
			//	await _roleManager.CreateAsync(new IdentityRole("User"));

			//}
			//if (await _roleManager.RoleExistsAsync("User"))
			//{
			//	await _userManager.AddToRoleAsync(user, "User");
			//}
			//return new OkResult();
		}

		//create method send authentication code via email
		public async Task<string> SendAuthenticationCode(string email)
		{
			var user = await _context.User.FirstOrDefaultAsync(x => x.Email == email);

			if (user == null)
			{
				return null;
			}

			var code = new Random().Next(100000, 999999).ToString();

			//send mail
			try
			{
				// Gửi email
				SendMail provider = new();
				await provider.SendEmailAsync(email, "Mã xác nhận của bạn", $"Mã xác nhận của bạn là: {code}");
				return code;
			}
			catch (Exception ex)
			{
				Console.WriteLine($"error: {ex.Message}");
			}
			return null;
		}
	}
}
