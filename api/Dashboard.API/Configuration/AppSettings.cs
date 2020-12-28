using Dashboard.API.Configuration.Models;

namespace Dashboard.API.Configuration
{
    public sealed class AppSettings
    {
        public DatabaseConfigurationModel Database { get; set; }

        public ServiceConfigurationModel Service { get; set; }
    }
}
