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
    }
}
