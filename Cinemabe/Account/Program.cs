using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.Repository;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System.Reflection;

namespace Cinema.Account
{
    public class Program
	{

		static async Task Main(string[] args)
		{
			var builder = new ConfigurationBuilder()
			   .SetBasePath(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location))
			   .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
			IConfigurationRoot config = builder.Build();

            var optionsBuilder = new DbContextOptionsBuilder<CinemaContext>();
			optionsBuilder.UseSqlServer(config.GetSection("ConnectionStrings").GetValue<string>("CinemaContext"));
			using (var context = new CinemaContext(optionsBuilder.Options))
			{
				IUserRepository userRepository = new UserRepository(context, config);

				var newUser = new User
				{
					UserName = "User",
					PasswordHash = "Hacker2k3@",
					PasswordSalt = "Hacker2k3@",
					FullName = "User",
					Email = "User@gmail.com",
					BirthDay = DateTime.UtcNow,
					Status = true,
				};
				var registeredUser = await userRepository.CreateAsync(newUser);

                Console.WriteLine($"Register success: {"UserName: " + registeredUser.UserName + "Password: " + newUser.PasswordHash}");
                Console.ReadLine();
            };

		}
	}
}
