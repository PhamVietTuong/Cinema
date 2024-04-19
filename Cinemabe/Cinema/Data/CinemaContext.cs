using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Cinema.Data.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

namespace Cinema.Data
{
    public class CinemaContext : DbContext
	{
        public CinemaContext (DbContextOptions<CinemaContext> options) : base(options) { }

		public DbSet<Cinema.Data.Models.User> User { get; set; }

		public DbSet<Cinema.Data.Models.UserType> UserType { get; set; }

		public DbSet<Cinema.Data.Models.Seat> Seat { get; set; }

		public DbSet<Cinema.Data.Models.ShowTime> ShowTime { get; set; }

        public DbSet<Cinema.Data.Models.AgeRestriction> AgeRestriction { get; set; }

        public DbSet<Cinema.Data.Models.TicketType> TicketType { get; set; }

        public DbSet<Cinema.Data.Models.FoodAndDrink> FoodAndDrink { get; set; }

        public DbSet<Cinema.Data.Models.Invoice> Invoice { get; set; }

        public DbSet<Cinema.Data.Models.InvoiceDetail> InvoiceDetail { get; set; }

        public DbSet<Cinema.Data.Models.Movie> Movie { get; set; }

        public DbSet<Cinema.Data.Models.MovieType> MovieType { get; set; }

        public DbSet<Cinema.Data.Models.MovieTypeDetail> MovieTypeDetail { get; set; }

        public DbSet<Cinema.Data.Models.Room> Room { get; set; }

        public DbSet<Cinema.Data.Models.ShowTimeType> ShowTimeType { get; set; }

        public DbSet<Cinema.Data.Models.Theater> Theater { get; set; }

        public DbSet<Cinema.Data.Models.SeatType> SeatType { get; set; }

        public DbSet<Cinema.Data.Models.InvoiceSeat> InvoiceSeat { get; set; }

        public DbSet<Cinema.Data.Models.InvoiceCombo> InvoiceCombo { get; set; }
	}
}
