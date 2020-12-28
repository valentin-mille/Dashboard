using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Dashboard.API.Clients.Trump;
using Dashboard.API.Models.Widgets.Trump;
using Refit;

namespace Dashboard.API.Controllers.Trump
{
    [ApiController]
    [Route("[controller]")]
    public sealed class TrumpController : ControllerBase
    {
        #region MEMBERS

        private readonly ILogger<TrumpController> _logger;

        #endregion MEMBERS

        #region CONSTRUCTORS

        public TrumpController(ILogger<TrumpController> logger)
        {
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES

        [HttpGet("quote")]
        public async Task<IActionResult> GetTrumpQuote()
        {
            _logger.LogInformation($"Requesting random Trump quote ...");

            var TrumpAPIClient = RestService.For<ITrumpApiClient>("https://api.tronalddump.io");
            TrumpQuoteWidgetModel quote = null;

            try
            {
                quote = await TrumpAPIClient.GetRandomQuote();
            }
            catch (ApiException exception)
            {
                _logger.LogError($"Error with Trump API. Details: {exception}");
                return StatusCode((int)exception.StatusCode);
            }
            return Ok(quote);
        }

        #endregion ROUTES

    }
}
