
using System;
using System.Net.Mime;
using Dashboard.API.Contexts;
using Dashboard.API.Models.Service;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Dashboard.API.Extensions
{
    public static class WebHostExtension
    {
        #region METHODS

        public static void SeedDatabase(this IHost host)
        {
            using var scope = host.Services.CreateScope();
            using var context = new DashboardContext(scope.ServiceProvider.GetRequiredService<DbContextOptions>());

            context.Database.Migrate();
            context.CreateDefaultDatabase();
        }

        #endregion METHODS
    }
}