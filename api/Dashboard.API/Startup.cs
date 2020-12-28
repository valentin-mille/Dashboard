using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.EntityFrameworkCore;
using Dashboard.API.Contexts;
using Dashboard.API.Repositories.Service;
using Dashboard.API.Repositories.User;
using Dashboard.API.Repositories.Widget;

namespace Dashboard.API
{
    public class Startup
    {
        #region PROPERTIES

        public IConfiguration Configuration { get; }

        #endregion PROPERTIES

        #region CONSTRUCTOR

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        #endregion CONSTRUCTOR

        #region METHODS

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddSingleton<Configuration.Provider.IConfigurationProvider, Configuration.Provider.ConfigurationProvider>();
            var configuration = services.BuildServiceProvider().GetRequiredService<Configuration.Provider.IConfigurationProvider>();
            
            services.AddScoped<IServiceRepository, ServiceRepository>();
            services.AddScoped<IWidgetRepository, WidgetRepository>();
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddDbContext<DashboardContext>(options =>
               options.UseNpgsql(configuration.AppSettings.Database.Connection));
            services.AddControllers()
                .AddNewtonsoftJson(x =>
                    x.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);
        }

        #endregion METHODS
    }
}
