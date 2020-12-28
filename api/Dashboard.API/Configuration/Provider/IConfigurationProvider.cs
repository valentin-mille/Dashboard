using Microsoft.Extensions.Configuration;
namespace Dashboard.API.Configuration.Provider
{
    public interface IConfigurationProvider
    {
        #region PROPERTIES

        AppSettings AppSettings { get; }

        #endregion PROPERTIES

        #region METHODS

        IConfiguration GetConfiguration();

        #endregion METHODS
    }
}
