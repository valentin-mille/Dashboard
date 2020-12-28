using System;
using System.Threading.Tasks;
using Dashboard.API.Repositories.ServiceUser;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace Dashboard.API.Controllers.ServiceUser
{
    public class ServiceUserController
    {
        #region MEMBERS

        private readonly IServiceUserRepository _serviceUserRepository;

        private readonly ILogger<ServiceUserController> _logger;

        #endregion MEMBERS
        
        #region CONSTRUCTORS

        public ServiceUserController(IServiceUserRepository serviceUserRepository, ILogger<ServiceUserController> logger)
        {
            _serviceUserRepository = serviceUserRepository;
            _logger = logger;
        }

        #endregion CONSTRUCTORS
        
        #region ROUTES

        // [HttpGet]
        // public async Task<IActionResult> GetElementList()
        // {
        //     _logger.LogInformation("(Service list) Service list fetch requested");
        //
        //     var elementList = await _serviceRepository.GetListAsync();
        //     return Ok(elementList);
        // }
        
        // [HttpGet("{userId}/{serviceId}")]
        // public async Task<IActionResult> GetServicesAsync([FromRoute] Guid userId, [FromRoute] Guid serviceId)
        // {
        //     _logger.LogInformation($"Requesting ServiceUser with id: {userId}/{serviceId} ...");
        //
        //     var service = await _serviceUserRepository.GetAsync(userId, serviceId);
        //     return Ok(service);
        // }
        
        #endregion ROUTES
    }
}