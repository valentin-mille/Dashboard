using System;
using System.Threading.Tasks;
using Dashboard.API.Clients.Movie;
using Dashboard.API.Models.Widgets.Movie;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.Extensions.Logging;
using Refit;

namespace Dashboard.API.Controllers.Movie
{
    [ApiController]
    [Route("[controller]")]
    public sealed class MovieController : ControllerBase
    {
        #region MEMBERS

        private readonly ILogger<Covid.CovidController> _logger;
        private readonly string _apiKey = Environment.GetEnvironmentVariable("MOVIESDB_KEY");

        #endregion MEMBERS

        #region CONSTRUCTORS

        public MovieController(ILogger<Covid.CovidController> logger)
        {
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES

        [HttpGet("{mediaType}/{timeWindow}")]
        public async Task<IActionResult> GetMovieTrend(string mediaType, string timeWindow)
        {
            _logger.LogInformation($"Requesting movie trend ...");

            var MovieApiClient = RestService.For<IMovieApiClient>("https://api.themoviedb.org/3/trending");
            MovieWidgetModel movieInformations = null;

            if (_apiKey == null)
            {
                _logger.LogError($"Cannot find MoviesDB api key. Check your environment");
                return NoContent();
            }
            try
            {
                movieInformations = await MovieApiClient.GetMovieTrend(mediaType, timeWindow, _apiKey);
            }
            catch (ApiException exception)
            {
                _logger.LogError($"Error with Movie API. Details: {exception}");
                return StatusCode((int)exception.StatusCode);
            }
            return Ok(movieInformations.MovieDataList);
        }
        #endregion ROUTES

    }
}