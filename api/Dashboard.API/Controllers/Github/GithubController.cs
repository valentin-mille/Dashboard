using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Dashboard.API.Clients.Github;
using Dashboard.API.Models.Github;
using Refit;

namespace Dashboard.API.Controllers.Github
{
    [ApiController]
    [Route("[controller]")]
    public sealed class GithubController : ControllerBase
    {
        #region MEMBERS

        private readonly ILogger<GithubController> _logger;

        #endregion MEMBERS

        #region CONSTRUCTORS

        public GithubController(ILogger<GithubController> logger)
        {
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES
        
        [HttpGet]
        public async Task<IActionResult> GetGithub()
        {
            _logger.LogInformation($"Requesting Github ...");
            return Ok();
        }

        [HttpGet("/users/repositories/{username}")]
        public async Task<IActionResult> GetUserRepositoriesAsync(string username)
        {
            _logger.LogInformation($"Requesting Github User {username} repositories...");
            
            var GithubAPIClient = RestService.For<IGithubApiClient>("https://api.github.com");
            GithubRepoModel userRepositories = null;

            try
            {
                userRepositories = await GithubAPIClient.GetUserRepository(username);
            }
            catch(ApiException exception)
            {
                _logger.LogError($"Error with Github API. Details: {exception}");
                return StatusCode((int)exception.StatusCode);
            }
            return Ok(userRepositories);
        }

        #endregion ROUTES
    }
}