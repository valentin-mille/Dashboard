using System.Threading.Tasks;
using Dashboard.API.Models.Widgets.Weather;
using Refit;

namespace Dashboard.API.Clients.Weather
{
    public interface IWeatherApiClient
    {
        [Get("/data/2.5/weather?q={city}&appid={apikey}&units=metric")]
        Task<WeatherWidgetModel> GetWeather(string city, string apikey);
    }
}
