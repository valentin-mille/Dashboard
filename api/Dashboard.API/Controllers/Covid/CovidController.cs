using System.Drawing.Printing;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Dashboard.API.Clients.Covid;
using Dashboard.API.Models.Widgets.Covid;
using Refit;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Dashboard.API.Controllers.Covid
{
    [ApiController]
    [Route("[controller]")]
    public sealed class CovidController : ControllerBase
    {
        #region MEMBERS

        private readonly ILogger<CovidController> _logger;

        #endregion MEMBERS

        #region CONSTRUCTORS

        public CovidController(ILogger<CovidController> logger)
        {
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES

        [HttpGet]
        public async Task<IActionResult> GetCovidStatsAsync()
        {
            _logger.LogInformation($"Requesting Covid Stats ...");

            _logger.LogInformation($"https://coronavirusapi-france.now.sh/FranceLiveGlobalData");

            var CovidAPIClient = RestService.For<ICovidApiClient>("https://coronavirusapi-france.now.sh");
            string currentCovidStats = null;
            JObject jsonCovidStats = null;

            try
            {
                currentCovidStats = await CovidAPIClient.GetCovidStats();
            }
            catch (ApiException exception)
            {
                _logger.LogError($"Error with Covid API. Details: {exception}");
                return StatusCode((int)exception.StatusCode);
            }

            jsonCovidStats = JObject.Parse(currentCovidStats);
            return Ok(jsonCovidStats.Root.First.First.First);
        }
        
        [HttpGet("{department}")]
        public async Task<IActionResult> GetCovidStatsAsyncByDepartment([FromRoute] string department)
        {
            var CovidAPIClient = RestService.For<ICovidApiClient>($"https://coronavirusapi-france.now.sh");
            string currentCovidStats = null;
            JObject jsonCovidStats = null;

            try
            {
                currentCovidStats = await CovidAPIClient.GetCovidStatsByDepartment(department);
            }
            catch (ApiException exception)
            {
                _logger.LogError($"Error with Covid API. Details: {exception}");
                return StatusCode((int)exception.StatusCode);
            }
            jsonCovidStats = JObject.Parse(currentCovidStats);
            return Ok(jsonCovidStats.Root.First.First.First);
        }

        #endregion ROUTES

    }
}
