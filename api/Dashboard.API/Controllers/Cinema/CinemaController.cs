using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Dashboard.API.Clients.Cinema;
using Dashboard.API.Models.Widgets.Cinema;
using Refit;

namespace Dashboard.API.Controllers.Cinema
{
    [ApiController]
    [Route("[controller]")]
    public sealed class CinemaController : ControllerBase
    {
        #region MEMBERS

        private readonly ILogger<CinemaController> _logger;
        private readonly string _apiKey = Environment.GetEnvironmentVariable("OMDP_KEY");

        #endregion MEMBERS

        #region CONSTRUCTORS

        public CinemaController(ILogger<CinemaController> logger)
        {
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES

        [HttpGet("movie/{title}")]
        public async Task<IActionResult> GetMovieReference(string title)
        {
            _logger.LogInformation($"Requesting Cinema movie ...");
            var CinemaAPIClient = RestService.For<ICinemaApiClient>("http://www.omdbapi.com");
            CinemaMovieWidgetModel Movie = null;
            
            if (_apiKey == null)
            {
                _logger.LogError($"Cannot find OMDB api key. Check your environment");
                return NoContent();
            }
            try
            {
                Movie = await CinemaAPIClient.GetMovie(title, _apiKey);
            }
            catch (ApiException exception)
            {
                _logger.LogError($"Error with Cinema API. Details: {exception}");
                return StatusCode((int)exception.StatusCode);
            }
            return Ok(Movie);
        }

        #endregion ROUTES

    }
}
