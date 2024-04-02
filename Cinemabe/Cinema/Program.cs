using Cinema.Contracts;
using Cinema.Data.Models;
using Cinema.Mappings;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.Extensions.DependencyInjection;
using Cinema.Data;
using Cinema;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();

builder.Services.AddDbContext<CinemaContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("CinemaContext") ?? throw new InvalidOperationException("Connection string 'CinemaContext' not found.")));

//Config cho Identity
builder.Services.AddIdentity<User, IdentityRole>()
                .AddEntityFrameworkStores<CinemaContext>()
                .AddDefaultTokenProviders();

// Config cho Authentication
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
})

// Config cho JWT
.AddJwtBearer(options =>
{
    options.SaveToken = true;
    options.RequireHttpsMetadata = false;
    options.TokenValidationParameters = new TokenValidationParameters()
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidAudience = builder.Configuration["JWT:ValidAudience"],
        ValidIssuer = builder.Configuration["JWT:ValidIssuer"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JWT:Secret"]))

    };
});

// Add services to the container.
builder.Services.AddControllers();

// Config CORS
builder.Services.AddCors(option =>
{
    option.AddDefaultPolicy(builder =>
    {
        builder
			  .WithOrigins("http://localhost:3000")
				.AllowAnyHeader()
				.AllowAnyMethod()
				.AllowCredentials();
    });
});

builder.Services.AddAutoMapper(typeof(MappingProfile).Assembly);

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSignalR();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
	app.UseSwagger();
	app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseAuthentication();

app.UseCors();

app.UseAuthorization();

app.UseRouting();

app.UseEndpoints(endpoints =>
{
	endpoints.MapHub<CinemaHub>("/cinema");
});

app.MapControllers();

app.Run();
