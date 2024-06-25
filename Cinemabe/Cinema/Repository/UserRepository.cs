using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Cinema.Helper;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Security.Cryptography;

namespace Cinema.Repository
{
	public class UserRepository : IUserRepository
	{
		private readonly CinemaContext _context;
		private readonly IConfiguration _configuration;

		public UserRepository(CinemaContext context, IConfiguration configuration)
		{
			_context = context;
			_configuration = configuration;
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

		public async Task<User> ValidateLogin(string userName, string password, string userType = null)
		{
			User userToValidate = null;

			if (userType == "user")
			{
				userToValidate = await _context.User.Where(x => x.Phone == userName || x.UserName == userName || x.Email == userName).FirstOrDefaultAsync();
			}
			else if (userType == "admin")
			{
				userToValidate = await _context.User.Where(x => x.Phone == userName || x.UserName == userName || x.Email == userName).FirstOrDefaultAsync();
			}

			return ValidateLogin(userToValidate, password);
		}

		public User ValidateLogin(User userToValidate, string password)
		{
			if (userToValidate != null)
			{
				PasswordHashSalt passwordHashSalt = new PasswordHashSalt
				{
					Hash = userToValidate.PasswordHash,
					Salt = userToValidate.PasswordSalt
				};

				if (PasswordUtils.ValidatePassword(password, passwordHashSalt))
				{
					return userToValidate;
				}
			}

			return null;
		}

		public async Task<TokenInfo> GenerateToken(string userName, string userType = null)
		{
			User user = null;
			string authority = string.Empty;
			int allowedHours = 3;

			if (userType == "user")
			{
				user = await _context.User.Where(x => x.Phone == userName || x.UserName == userName || x.Email == userName).FirstOrDefaultAsync();
				authority = "user";
			}
			else if (userType == "admin")
			{
				user = await _context.User.Where(x => x.Phone == userName || x.UserName == userName || x.Email == userName).FirstOrDefaultAsync();
				authority = "admin";
			}

			if (user != null)
			{
				user.UserType = await _context.UserType.FindAsync(user.UserTypeId);

				var role = user.UserType.Name;
				var userId = user.Id.ToString();
				var tokenHandler = new JwtSecurityTokenHandler();
				var key = Encoding.ASCII.GetBytes(_configuration["JWT:Secret"]);
				DateTime expirationTime = DateTime.Now.AddHours(allowedHours);

				var tokenDescriptor = new SecurityTokenDescriptor
				{
					Subject = new ClaimsIdentity(new[] { new Claim(ClaimTypes.Name, userName), new Claim(ClaimTypes.Role, role), new Claim(ClaimTypes.NameIdentifier, userId) }),
					Issuer = _configuration["JWT:ValidIssuer"],
					Audience = _configuration["JWT:ValidAudience"],
					Expires = expirationTime,
					SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
				};
				var token = tokenHandler.CreateToken(tokenDescriptor);

				return new TokenInfo
				{
					Token = tokenHandler.WriteToken(token),
					ExpirationTime = expirationTime,
					Authority = authority
				};
			}
			else
			{
				return null;
			}
		}

		public async Task<User> Register(Register register)
		{
			try
			{
				if (string.IsNullOrEmpty(register.UserName) || string.IsNullOrEmpty(register.FullName) ||
					string.IsNullOrEmpty(register.Password) || string.IsNullOrEmpty(register.ConfirmPassword))
				{
					throw new ArgumentException("Tên người dùng, họ và tên, mật khẩu không được để trống.");
				}

				var existingUser = await _context.User.FirstOrDefaultAsync(u => u.UserName.ToLower() == register.UserName.ToLower());
				if (existingUser != null)
				{
					throw new ArgumentException("Tên người dùng đã tồn tại.");
				}

				if (!string.IsNullOrEmpty(register.Email))
				{

					var existingEmail = await _context.User.FirstOrDefaultAsync(u => u.Email.ToLower() == register.Email.ToLower());
					if (existingEmail != null)
					{
						throw new ArgumentException("Email đã được đăng ký trước đó.");
					}
				}

				if (!string.IsNullOrEmpty(register.Phone))
				{
					var existingPhone = await _context.User.FirstOrDefaultAsync(u => u.Phone == register.Phone);
					if (existingPhone != null)
					{
						throw new ArgumentException("Số điện thoại đã được sử dụng để đăng ký trước đó.");
					}
				}

				if (register.Password != register.ConfirmPassword)
				{
					throw new ArgumentException("Mật khẩu và mật khẩu nhập lại không khớp.");
				}

				var passwordHashSalt = PasswordUtils.EncryptPassword(register.Password);
				// var userType = _context.UserType.SingleOrDefault(ut => ut.Id == register.UserTypeId);
				// if (userType == null)
				// {
				// 	throw new Exception("UserType not found");
				// }
				var newUser = new User
				{
					Id = Guid.NewGuid(),
					UserTypeId = register.UserTypeId,
					UserName = register.UserName,
					FullName = register.FullName,
					Email = register.Email,
					Phone = register.Phone,
					BirthDay = register.BirthDay,
					Gender = register.Gender,
					Status = true,
					PasswordSalt = passwordHashSalt.Salt,
					PasswordHash = passwordHashSalt.Hash,
				};

				await _context.User.AddAsync(newUser);
				await _context.SaveChangesAsync();

				return newUser;
			}
			catch (ArgumentException)
			{
				throw;
			}
			catch (Exception ex)
			{
				throw new Exception("Đăng ký người dùng thất bại.", ex);
			}
		}


		//create method send authentication code via email
		public async Task<string> SendAuthenticationCode(string email)
		{
			var user = await _context.User.Where(x => x.Email == email).FirstOrDefaultAsync();

			if (user == null)
			{
				return null;
			}

			var code = new Random().Next(100000, 999999).ToString();


			// Gửi email
			SendMail provider = new();
			var result = await provider.SendEmailAsync(email, "Mã xác nhận của bạn", $"<H1>Mã xác nhận của bạn là: {code}</H1>");
			return result ? code : null;
		}

		public async Task<bool> ChangePassword(string PassWord, string UserName)
		{
			var user = await _context.User.Where(x => x.UserName == UserName || x.Phone == UserName || x.Email == UserName).FirstOrDefaultAsync();

			if (user == null)
			{
				return false;
			}
			var passwordHashSalt = PasswordUtils.EncryptPassword(PassWord);
			user.PasswordHash = passwordHashSalt.Hash;
			user.PasswordSalt = passwordHashSalt.Salt;
			_context.User.Update(user);
			await _context.SaveChangesAsync();
			return true;
		}
	}
}
