using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Dashboard.API.Clients.Nasa;
using Dashboard.API.Models.Widgets.Nasa;
using Refit;

namespace Dashboard.API.Controllers.Nasa
{
    [ApiController]
    [Route("[controller]")]
    public sealed class NasaController : ControllerBase
    {
        #region MEMBERS

        private readonly ILogger<NasaController> _logger;
        private readonly string _apiKey = Environment.GetEnvironmentVariable("NASA_KEY");

        #endregion MEMBERS

        #region CONSTRUCTORS

        public NasaController(ILogger<NasaController> logger)
        {
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES

        [HttpGet("apod")]
        public async Task<IActionResult> GetApodAsync()
        {
            _logger.LogInformation($"Requesting Nasa Apod ...");
            
            var NasaAPIClient = RestService.For<INasaApiClient>("https://api.nasa.gov");
            NasaApodWidgetModel NasaApod = null;

            if (_apiKey == null)
            {
                _logger.LogError($"Cannot find Nasa api key. Check your environment");
                return NoContent();
            }
            try
            {
                NasaApod = await NasaAPIClient.GetPicture(_apiKey);
            }
            catch (ApiException exception)
            {
                _logger.LogError($"Error with Nasa API. Details: {exception}");
                return StatusCode((int)exception.StatusCode);
            }
            return Ok(NasaApod);
        }

        #endregion ROUTES

    }
}
