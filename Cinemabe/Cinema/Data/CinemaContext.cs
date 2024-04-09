using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Cinema.Data.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

namespace Cinema.Data
{
    public class CinemaContext : IdentityDbContext<User>
	{
        public CinemaContext (DbContextOptions<CinemaContext> options) : base(options) { }

		public DbSet<Cinema.Data.Models.Ticket> Tickets { get; set; } = default!;

        public DbSet<Cinema.Data.Models.Chair> Chairs { get; set; }

        public DbSet<Cinema.Data.Models.ShowTime> ShowTimes { get; set; }

        public DbSet<Cinema.Data.Models.AgeRestriction> AgeRestrictions { get; set; }

        public DbSet<Cinema.Data.Models.ChairType> ChairTypes { get; set; }

        public DbSet<Cinema.Data.Models.FoodAndDrink> FoodAndDrinks { get; set; }

        public DbSet<Cinema.Data.Models.Invoice> Invoices { get; set; }

        public DbSet<Cinema.Data.Models.InvoiceDetail> InvoiceDetails { get; set; }

        public DbSet<Cinema.Data.Models.RowChair> RowChairs { get; set; }

        public DbSet<Cinema.Data.Models.Movie> Movies { get; set; }

        public DbSet<Cinema.Data.Models.MovieType> MovieTypes { get; set; }

        public DbSet<Cinema.Data.Models.MovieTypeDetail> MovieTypeDetails { get; set; }

        public DbSet<Cinema.Data.Models.Room> Rooms { get; set; }

        public DbSet<Cinema.Data.Models.ShowTimeType> ShowTimeTypes { get; set; }

        public DbSet<Cinema.Data.Models.Theater> Theaters { get; set; }
	}
}
