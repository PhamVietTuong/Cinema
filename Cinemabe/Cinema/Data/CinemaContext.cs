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

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<MovieTypeDetail>()
                .HasKey(x => new { x.MovieId, x.MovieTypeId });

            modelBuilder.Entity<ShowTimeRoom>()
                .HasKey(x => new { x.ShowTimeId, x.RoomId });

            modelBuilder.Entity<SeatTypeTicketType>()
                .HasKey(x => new { x.SeatTypeId, x.TicketTypeId });

            modelBuilder.Entity<FoodAndDrinkTheater>()
               .HasKey(x => new { x.FoodAndDrinkId, x.TheaterId });

            modelBuilder.Entity<InvoiceTicket>()
                .HasKey(x => new { x.InvoiceId, x.ShowTimeId, x.SeatId, x.TicketTypeId });

            modelBuilder.Entity<InvoiceFoodAndDrink>()
                .HasKey(x => new { x.InvoiceId, x.FoodAndDrinkId });
        }

        public DbSet<User> User { get; set; }

        public DbSet<UserType> UserType { get; set; }

        public DbSet<Seat> Seat { get; set; }

        public DbSet<ShowTime> ShowTime { get; set; }

        public DbSet<AgeRestriction> AgeRestriction { get; set; }

        public DbSet<TicketType> TicketType { get; set; }

        public DbSet<FoodAndDrink> FoodAndDrink { get; set; }

        public DbSet<Movie> Movie { get; set; }

        public DbSet<MovieType> MovieType { get; set; }

        public DbSet<MovieTypeDetail> MovieTypeDetail { get; set; }

        public DbSet<Room> Room { get; set; }

        public DbSet<Theater> Theater { get; set; }

        public DbSet<SeatType> SeatType { get; set; }

        public DbSet<ShowTimeRoom> ShowTimeRoom { get; set; }

        public DbSet<SeatTypeTicketType> SeatTypeTicketType { get; set; }

        public DbSet<InvoiceFoodAndDrink> InvoiceFoodAndDrink { get; set; }

        public DbSet<InvoiceTicket> InvoiceTicket { get; set; }

        public DbSet<Invoice> Invoice { get; set; }

        public DbSet<FoodAndDrinkTheater> FoodAndDrinkTheater { get; set; }
    }
}
