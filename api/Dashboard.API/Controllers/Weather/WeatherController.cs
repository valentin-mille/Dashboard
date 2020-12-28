using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Dashboard.API.Clients.Weather;
using Dashboard.API.Models.Widgets.Weather;
using Refit;

namespace Dashboard.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public sealed class WeatherController : ControllerBase
    {
        #region MEMBERS

        private readonly ILogger<WeatherController> _logger;
        private readonly string _apiKey = Environment.GetEnvironmentVariable("WEATHER_KEY");

        #endregion MEMBERS

        #region CONSTRUCTORS

        public WeatherController(ILogger<WeatherController> logger)
        {
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES

        [HttpGet("{city}")]
        public async Task<IActionResult> GetWeatherAsync(string city)
        {
            _logger.LogInformation($"Requesting Weather {city}...");
            
            var WeatherAPIClient = RestService.For<IWeatherApiClient>("https://api.openweathermap.org");
            WeatherWidgetModel currentWeather = null;

            if (_apiKey == null)
            {
                _logger.LogError($"Cannot find Weather api key. Check your environment");
                return NoContent();
            }
            try
            {
                currentWeather = await WeatherAPIClient.GetWeather(city, _apiKey);
            }
            catch(ApiException exception)
            {
                _logger.LogError($"Error with Weather API. Details: {exception}");
                return StatusCode((int)exception.StatusCode);
            }
            return Ok(currentWeather);
        }

        #endregion ROUTES
    }
}
