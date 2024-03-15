using Cinema.Data.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Data.Contexts
{
	public class CinemaContext : IdentityDbContext<User>
	{
		public CinemaContext(DbContextOptions<CinemaContext> options) : base(options) { }

		public DbSet<AgeRestriction> AgeRestrictions { get; set; }
		public DbSet<Chair> Chairs { get; set; }
		public DbSet<ChairType> ChairTypes { get; set; }
		public DbSet<FoodAndDrink> FoodAndDrinks { get; set; }
		public DbSet<Invoice> Invoices { get; set; }
		public DbSet<InvoiceDetail> InvoiceDetails { get; set; }
		public DbSet<Movie> Movies { get; set; }
		public DbSet<MovieType> MovieTypes { get; set; }
		public DbSet<MovieTypeDetail> MovieTypeDetails { get; set; }
		public DbSet<Room> Rooms { get; set; }
		public DbSet<ShowTime> ShowTimes { get; set; }
		public DbSet<ShowTimeType> ShowTimeTypes { get; set; }
		public DbSet<Theater> Theaters { get; set; }
		public DbSet<Ticket> Tickets { get; set; }
	}
}
