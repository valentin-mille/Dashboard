using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Dashboard.API.Models.Service;
using Dashboard.API.Constants;
using Dashboard.API.Models.ServiceUser;
using Dashboard.API.Models.User;
using Dashboard.API.Models.Widget;

namespace Dashboard.API.Contexts
{
    public class DashboardContext: DbContext
    {

        #region TABLES

        public DbSet<UserModel> Users { get; set; }

        public DbSet<ServiceModel> Services { get; set; }

        public DbSet<WidgetModel> Widgets { get; set; }
        
        public DbSet<ServiceUserModel> ServiceUser { get; set; }
        

        #endregion TABLES

        #region CONSTRUCTORS

        public DashboardContext(DbContextOptions options): base(options)
        {
        }

        #endregion CONSTRUCTORS

        #region BUILDERS

        private static void BuildUsersTable(ModelBuilder modelBuilder)
        {
            // Table name
            modelBuilder.Entity<UserModel>()
                .ToTable(ContextConstants.UserTableName);

            // Keys and relationships
            modelBuilder.Entity<UserModel>()
                .HasKey(user => user.UserId);

            // Indices
            modelBuilder.Entity<UserModel>()
                .HasIndex(user => user.UserId)
                .IsUnique();
        }

        private static void BuildServicesTable(ModelBuilder modelBuilder)
        {
            // Table name
            modelBuilder.Entity<ServiceModel>()
                .ToTable(ContextConstants.ServiceTableName);

            // Keys and relationships
            modelBuilder.Entity<ServiceModel>()
                .HasKey(service => service.ServiceId);

            // Indices
            modelBuilder.Entity<ServiceModel>()
                .HasIndex(service => service.ServiceId)
                .IsUnique();
        }

        private static void BuildWidgetsTable(ModelBuilder modelBuilder)
        {
            // Table name
            modelBuilder.Entity<WidgetModel>()
                .ToTable(ContextConstants.WidgetTableName);

            // Keys and relationships
            modelBuilder.Entity<WidgetModel>()
                .HasKey(widget => widget.WidgetId);

            // Indices
            modelBuilder.Entity<WidgetModel>()
                .HasIndex(widget => widget.WidgetId)
                .IsUnique();

            modelBuilder.Entity<WidgetModel>()
                .HasOne(w => w.Service)
                .WithMany(s => s.Widgets)
                .HasForeignKey(w => w.ServiceId);

        }

        private static void BuidServiceUserTable(ModelBuilder modelBuilder)
        {
            // Table name
            modelBuilder.Entity<ServiceUserModel>()
                .ToTable(ContextConstants.UserServiceTableName);
            
            // Keys and relationships
            modelBuilder.Entity<ServiceUserModel>()
                .HasKey(su => new { su.ServiceId, su.UserId });
            modelBuilder.Entity<ServiceUserModel>()
                .HasOne(su => su.Service)
                .WithMany(s => s.ServiceUsers)
                .HasForeignKey(su => su.ServiceId);
            modelBuilder.Entity<ServiceUserModel>()
                .HasOne(su => su.User)
                .WithMany(u => u.ServiceUsers)
                .HasForeignKey(su => su.UserId);
        }

        #endregion BUILDERS

        #region METHODS

        public override void Dispose()
        {
            ChangeTracker.DetectChanges();
            SaveChanges();
        }

        // EntryPoint
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            BuildUsersTable(modelBuilder);
            BuildServicesTable(modelBuilder);
            BuildWidgetsTable(modelBuilder);
            BuidServiceUserTable(modelBuilder);
        }

        public void CreateDefaultDatabase()
        {
            Guid cinemaUuid = Guid.NewGuid();
            Guid covidUuid = Guid.NewGuid();
            Guid githubUuid = Guid.NewGuid();
            Guid movieUuid = Guid.NewGuid();
            Guid nasaUuid = Guid.NewGuid();
            Guid trumpUuid = Guid.NewGuid();
            Guid weatherUuid = Guid.NewGuid();

            if (Services.Any())
            {
                return;
            }
            Services.Add(
                new ServiceModel
                {
                    ServiceId = cinemaUuid,
                    ServiceName = "Cinema",
                    UrlImage = "https://assets.brandfetch.io/85fc1cf3acf5416.png",
                    AuthorizeUrl = "",
                    AccessToken = "",
                    
                });
            Widgets.Add(new WidgetModel
            {
                    ServiceId = cinemaUuid,
                    WidgetName = "Cinema movies informations",
                    WidgetDescription = "Display informations about a movie"
            });
            Services.Add(
                new ServiceModel
                {
                    ServiceId = covidUuid,
                    ServiceName = "Covid",
                    UrlImage = "https://assets.brandfetch.io/6018cca55d01491.png",
                    AuthorizeUrl = "",
                    AccessToken = "",
                    
                });
            Widgets.Add( 
                new WidgetModel
                {
                    ServiceId = covidUuid,
                    WidgetName = "Covid French Tracker",
                    WidgetDescription = "Display information about the covid in France"
                });
            Services.Add(
                new ServiceModel
                {
                    ServiceId = githubUuid,
                    ServiceName = "Github",
                    UrlImage = "https://assets.brandfetch.io/62991192576d44c.png",
                    AuthorizeUrl = "https://github.com/login/oauth/authorize",
                    AccessToken = "https://github.com/login/oauth/access_token",
                });
            
            Widgets.Add(
                new WidgetModel
                {
                    ServiceId = githubUuid,
                    WidgetName = "Github Manager",
                    WidgetDescription = "Offers the possibility to see and create repositories",
                });
            
            Services.Add(
                new ServiceModel
                {
                    ServiceId = movieUuid,
                    ServiceName = "Movie",
                    UrlImage = "https://assets.brandfetch.io/fe2ed100aa4149f.png",
                    AuthorizeUrl = "",
                    AccessToken = "",

                });
            Widgets.Add(
                new WidgetModel
                {
                    ServiceId = movieUuid, 
                    WidgetName = "Movie Trend",
                    WidgetDescription = "Get the last movie, serie trending in the world",
            });
            
            Services.Add(
                new ServiceModel
                {
                    ServiceId = nasaUuid,
                    ServiceName = "Nasa",
                    UrlImage = "https://assets.brandfetch.io/147763f045ea4b0.png",
                    AuthorizeUrl = "",
                    AccessToken = "",

                });
            Widgets.Add(
                new WidgetModel 
                {
                    ServiceId = nasaUuid,
                    WidgetName = "Nasa day's image",
                    WidgetDescription = "Display the day's image of planet or space",
                });
            
            Services.Add(
                new ServiceModel
                {
                    ServiceId = trumpUuid,
                    ServiceName = "Trump",
                    UrlImage = "https://assets.brandfetch.io/17f7e914fb11413.png",
                    AuthorizeUrl = "",
                    AccessToken = "",
                });
            Widgets.Add(
                new WidgetModel
                {
                    ServiceId = trumpUuid,
                    WidgetName = "Trump quotes",
                    WidgetDescription = "Display random quotes of Trump (:",
                });
            Services.Add(
                new ServiceModel
                {
                    ServiceId = weatherUuid,
                    ServiceName = "Weather",
                    UrlImage = "https://assets.brandfetch.io/e15acb0dae4849f.png",
                    AuthorizeUrl = "",
                    AccessToken = "",
                });
            Widgets.Add(
                new WidgetModel
                {
                    ServiceId = weatherUuid,
                    WidgetName = "Weather City",
                    WidgetDescription = "Display weather data of the selected city"
            });
        }

        #endregion METHODS
    }
}
