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
using AutoMapper;

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
			var userTypeExit = await _context.UserType.AnyAsync(x => x.Name == "user");

			var userTypes = await _context.UserType.ToListAsync();


			if (!userTypeExit)
			{
				var newUserTypes = new UserType
				{
					Name = "admin",
				};

				await _context.AddAsync(newUserTypes);

				entity.UserTypeId = newUserTypes.Id;
				entity.PasswordHash = passwordHashSalt.Hash;
				entity.PasswordSalt = passwordHashSalt.Salt;
				await _context.AddAsync(entity);
			}
			else
			{
				entity.UserTypeId = userTypes.First(x => x.Name == "user").Id;
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
				userToValidate = await _context.User.Where(x => x.Phone == userName || x.Email == userName).FirstOrDefaultAsync();
			}
			else if (userType == "admin")
			{
				userToValidate = await _context.User.Where(x => x.Phone == userName || x.Email == userName).FirstOrDefaultAsync();
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

			if (userType == "user")
			{
				user = await _context.User.Where(x => x.Phone == userName || x.Email == userName).FirstOrDefaultAsync();
				authority = "user";
			}
			else if (userType == "admin")
			{
				user = await _context.User.Where(x => x.Phone == userName || x.Email == userName).FirstOrDefaultAsync();
				authority = "admin";
			}

			if (user != null)
			{
				user.UserType = await _context.UserType.FindAsync(user.UserTypeId);

				var role = user.UserType.Name;
				var tokenHandler = new JwtSecurityTokenHandler();
				var key = Encoding.ASCII.GetBytes(_configuration["JWT:Secret"]);
                DateTime expirationTime = DateTime.Now.AddYears(3);

                var tokenDescriptor = new SecurityTokenDescriptor
				{
					Subject = new ClaimsIdentity(new[] { new Claim(ClaimTypes.Name, userName), new Claim(ClaimTypes.Role, role)}),
					Issuer = _configuration["JWT:ValidIssuer"],
					Audience = _configuration["JWT:ValidAudience"],
					SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature),
                    Expires = expirationTime,
                };

                var token = tokenHandler.CreateToken(tokenDescriptor);

				return new TokenInfo
				{
					Token = tokenHandler.WriteToken(token),
					Authority = role
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
				if (string.IsNullOrEmpty(register.FullName) ||
					string.IsNullOrEmpty(register.Password) || string.IsNullOrEmpty(register.ConfirmPassword) || string.IsNullOrEmpty(register.Email) || string.IsNullOrEmpty(register.Phone)|| string.IsNullOrEmpty(register.BirthDay.ToString()))
				{
					throw new ArgumentException("Họ và tên, email, số điện thoại, ngày sinh, mật khẩu không được để trống.");
				}

				if (!Validate.IsValidPassword(register.Password))
				{
					throw new ArgumentException("Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
				}
				if ( !Validate.IsEmail(register.Email))
				{
					throw new ArgumentException("Địa chỉ email không hợp lệ.");
				}

				if (!Validate.IsPhoneNumber(register.Phone))
				{
					throw new ArgumentException("Số điện thoại không hợp lệ.");
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

				// Tìm UserTypeID từ UserTypeName
				var userType = await _context.UserType.FirstOrDefaultAsync(ut => ut.Name == register.UserTypeName.ToLower());
				if (userType == null)
				{
					throw new ArgumentException($"Loại người dùng '{register.UserTypeName}' không tồn tại.");
				}

				var passwordHashSalt = PasswordUtils.EncryptPassword(register.Password);

				var memberFirst = await _context.MemberShip.FirstOrDefaultAsync(x => x.Value == 0);
				var newUser = new User
				{
					UserTypeId = userType.Id,
					FullName = register.FullName,
					Email = register.Email,
					Phone = register.Phone,
					BirthDay = register.BirthDay,
					//nam:true, nu:false
					Gender = register.Gender,
					MemberShipId = memberFirst.Id,
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
		public async Task<ResultSendCode> SendAuthenticationCode(string email)
		{
			ResultSendCode resCode = new();
			var user = await _context.User.Where(x => x.Email == email).FirstOrDefaultAsync();

			if (user == null)
			{
				resCode.IsSuccess = false;
				resCode.Message = "Không tìm thấy email";
				return resCode;
			}

			var code = new Random().Next(100000, 999999).ToString();


			// Gửi email
			SendMail provider = new();
			var result = await provider.SendEmailAsync(email, "Mã xác nhận quên mật khẩu", $"<H1>Mã xác nhận của bạn là: {code}</H1>");
			if (result)
			{
				resCode.IsSuccess = true;
				resCode.Message = code;
			}
			else
			{
				resCode.IsSuccess = false;
				resCode.Message = "Gửi email thất bại";
			}
			return resCode;
		}

		public async Task<bool> ChangePassword(string PassWord, string UserName)
		{
			var user = await _context.User.Where(x => x.Phone == UserName || x.Email == UserName).FirstOrDefaultAsync();

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

		public async Task<bool> ExistsAsync(string phone)
		{
			return await _context.User.AnyAsync(x => x.Phone == phone);
		}

		public async Task<UserDTO> UpdateAsync(UserDTO entity)
		{
			var user = await _context.User.FirstOrDefaultAsync(x => x.Phone == entity.Phone);

			user.FullName = entity.FullName;
			user.Email = entity.Email;
			user.Gender = entity.Gender;
			user.BirthDay = entity.BirthDay;

			await _context.SaveChangesAsync();

			return entity;
		}

		public async Task<List<UserRowViewModel>> GetListUserAsync()
		{
			var result = new List<UserRowViewModel>();

			var users = await _context.User
								.Include(x => x.UserType)
								.ToListAsync();

			foreach (var user in users)
			{
				result.Add(new UserRowViewModel
				{
					FullName = user.FullName,
					BirthDay = user.BirthDay,
					Gender = user.Gender,
					Phone = user.Phone,
					Email = user.Email,
					UserType = user.UserType.Name,
				});
			}

			return result;
		}
	}
}
