using System;
using System.Threading.Tasks;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Dashboard.API.Contexts;

namespace Dashboard.API.Controllers.About
{
    [ApiController]
    [Route("[controller].json")]
    public sealed class AboutController : ControllerBase
    {
        #region MEMBERS
        
        private readonly DashboardContext _context;

        private readonly ILogger<AboutController> _logger;

        #endregion MEMBERS

        #region CONSTRUCTORS

        public AboutController(DashboardContext context, ILogger<AboutController> logger)
        {
            _context = context;
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES

        [HttpGet]
        public async Task<IActionResult> GetAboutServerAsync()
        {
            _logger.LogInformation($"Requesting about.json object ...");
            Int32 unixTimestamp = (Int32)(DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
            var remoteIpAddress = HttpContext.Connection.RemoteIpAddress.MapToIPv4().ToString();
            
            var ServerServices = from s in _context.Services
                orderby s.ServiceName
                select s;
            ServerServices.ToList();

            var aboutFile = new
            {
                customer = new {
                    host = remoteIpAddress
                },
                server = new {
                    current_time = unixTimestamp,
                    services = ServerServices
                }

            };

            var aboutSerialized = JsonConvert.SerializeObject(aboutFile, Formatting.Indented);
            return Ok(aboutSerialized);
        }

        #endregion ROUTES
    }
}