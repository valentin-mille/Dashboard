using System;
using System.Threading.Tasks;
using Dashboard.API.Constants;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Dashboard.API.Repositories.Service;

namespace Dashboard.API.Controllers.Service
{
    [ApiController]
    [Route(ControllerConstants.ServiceControllerRoute)]
    public sealed class ServiceController : ControllerBase
    {
        #region MEMBERS

        private readonly IServiceRepository _serviceRepository;

        private readonly ILogger<ServiceController> _logger;

        #endregion MEMBERS

        #region CONSTRUCTORS

        public ServiceController(IServiceRepository serviceRepository, ILogger<ServiceController> logger)
        {
            _serviceRepository = serviceRepository;
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES

        [HttpGet]
        public async Task<IActionResult> GetElementList()
        {
            _logger.LogInformation("(Service list) Service list fetch requested");

            var elementList = await _serviceRepository.GetListAsync();
            return Ok(elementList);
        }
        
        [HttpGet("{id}")]
        public async Task<IActionResult> GetServicesAsync([FromRoute] Guid id)
        {
            _logger.LogInformation($"Requesting service with id: {id} ...");
        
            var service = await _serviceRepository.GetAsync(id);
            return Ok(service);
        }
        
        [HttpGet("user/{id}")]
        public async Task<IActionResult> GetUserServices(Guid id)
        {
            _logger.LogInformation($"Requesting services of user {id} ...");
            var services = await _serviceRepository.GetListRelationById(id);
            return Ok(services);
        }
        
        [HttpPost("user/{userId}/{serviceId}")]
        public async Task<IActionResult> AddServiceToUser(Guid userId, Guid serviceId)
        {
            _logger.LogInformation($"Adding service {serviceId} to user {userId} ...");
            if (await _serviceRepository.IsServiceAlreadyLinkedToUser(serviceId, userId))
            {
                return NotFound();
            }
            var serviceAdded = await _serviceRepository.AddServiceToUser(userId, serviceId);
            return Ok(serviceAdded);
        }
        
        [HttpDelete("user/{userId}/{serviceId}")]
        public async Task<IActionResult> DeleteServiceFromUser(Guid userId, Guid serviceId)
        {
            _logger.LogInformation($"Deleting service {serviceId} from user {userId} ...");
            var serviceDeleted = await _serviceRepository.DeleteServiceFromUser(serviceId, userId);
            return Ok(serviceDeleted);
        }

        #endregion ROUTES
    }
}