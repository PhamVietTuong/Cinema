using Cinema.Contracts;
using Cinema.Mappings;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Cinema.Data;
using Cinema;
using Cinema.DTOs;
using Cinema.Repository;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<CinemaContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("CinemaContext") ?? throw new InvalidOperationException("Connection string 'CinemaContext' not found.")));

builder.Services.AddCors(options =>
{
    options.AddPolicy(
                   "CorsPolicy", builder => 
                  builder.WithOrigins("http://localhost:3000", "http://103.104.122.137:9002")
                   .AllowAnyMethod()
                   .AllowAnyHeader()
                   .AllowCredentials());
});

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
})

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

builder.Services.AddControllers();
builder.Services.AddScoped<IAgeRestrictionRepository, AgeRestrictionRepository>();
builder.Services.AddScoped<IFoodAndDrinkRepository, FoodAndDrinkRepository>();
builder.Services.AddScoped<IInvoiceRepository, InvoiceRepository>();
builder.Services.AddScoped<IMovieRepository, MovieRepository>();
builder.Services.AddScoped<ISeatRepository, SeatRepository>();
builder.Services.AddScoped<ITheaterRepository, TheaterRepository>();
builder.Services.AddScoped<ITicketTypeRepository, TicketTypeRepository>();
builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IMomoRepository, MomoRepository>();
builder.Services.AddScoped<IMovieTypeRepository, MovieTypeRepository>();
builder.Services.AddScoped<ISeatTypeRepository, SeatTypeRepository>();
builder.Services.AddScoped<IUserTypeRepository, UserTypeRepository>();
builder.Services.AddScoped<INewsRepository, NewsRepository>();

builder.Services.AddAutoMapper(typeof(MappingProfile).Assembly);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSignalR();
builder.Services.AddSingleton<IDictionary<string, InfoTicketBooking>>(options => new Dictionary<string, InfoTicketBooking>());

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseCors("CorsPolicy");

app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();

app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    app.MapControllers();
    endpoints.MapHub<CinemaHub>("/cinema");
});


app.Run();
