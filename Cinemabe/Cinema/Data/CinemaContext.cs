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
            modelBuilder.Entity<InvoiceTicket>()
                .HasKey(x => new { x.Code, x.ShowTimeId, x.TicketTypeId, x.RoomId, x.ColIndex, x.RowName });

            modelBuilder.Entity<Seat>()
                .HasKey(x => new { x.RoomId, x.ColIndex, x.RowName });

            modelBuilder.Entity<MovieTypeDetail>()
                .HasKey(x => new { x.MovieId, x.MovieTypeId });

            modelBuilder.Entity<ShowTimeRoom>()
                .HasKey(x => new { x.ShowTimeId, x.RoomId });

            modelBuilder.Entity<SeatTypeTicketType>()
                .HasKey(x => new { x.SeatTypeId, x.TicketTypeId });

            modelBuilder.Entity<FoodAndDrinkTheater>()
               .HasKey(x => new { x.FoodAndDrinkId, x.TheaterId });

            modelBuilder.Entity<InvoiceFoodAndDrink>()
                .HasKey(x => new { x.Code, x.FoodAndDrinkId });

            modelBuilder.Entity<Invoice>()
                .HasKey(x => new { x.Code });

            modelBuilder.Entity<User>()
                .HasKey(x => new { x.Phone });

            modelBuilder.Entity<Evaluation>()
                .HasKey(x => new { x.Phone, x.MovieId });
            modelBuilder.Entity<Discount>()
                .HasKey(x => new { x.Code });
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
        public DbSet<News> News { get; set; }
        public DbSet<MemberShip> MemberShip { get; set; }
        public DbSet<Comment> Comment { get; set; }
        public DbSet<Evaluation> Evaluation { get; set; }
        public DbSet<Holiday> Holiday { get; set; }
        public DbSet<DiscountType> DiscountType { get; set; }
        public DbSet<Discount> Discount { get; set; }
    }
}
