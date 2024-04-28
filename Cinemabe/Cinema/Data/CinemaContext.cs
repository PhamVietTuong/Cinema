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
        public CinemaContext(DbContextOptions<CinemaContext> options) : base(options) { }

        public DbSet<User> User { get; set; }

        public DbSet<UserType> UserType { get; set; }

        public DbSet<Seat> Seat { get; set; }

        public DbSet<ShowTime> ShowTime { get; set; }

        public DbSet<AgeRestriction> AgeRestriction { get; set; }

        public DbSet<TicketType> TicketType { get; set; }

        public DbSet<FoodAndDrink> FoodAndDrink { get; set; }

        public DbSet<Ticket> Ticket { get; set; }

        public DbSet<InvoiceDetail> InvoiceDetail { get; set; }

        public DbSet<Movie> Movie { get; set; }

        public DbSet<MovieType> MovieType { get; set; }

        public DbSet<MovieTypeDetail> MovieTypeDetail { get; set; }

        public DbSet<Room> Room { get; set; }

        public DbSet<ShowTimeType> ShowTimeType { get; set; }

        public DbSet<Theater> Theater { get; set; }

        public DbSet<SeatType> SeatType { get; set; }

        public DbSet<ShowTimeRoom> ShowTimeRoom { get; set; }
    }
}
