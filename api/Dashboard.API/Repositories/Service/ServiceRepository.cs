using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Dashboard.API.Contexts;
using Dashboard.API.Exceptions.Http;
using Dashboard.API.Models.Service;
using Dashboard.API.Models.ServiceUser;
using Dashboard.API.Models.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Dashboard.API.Repositories.Service
{
    public sealed class ServiceRepository: IServiceRepository
    {
        #region MEMBERS

        private readonly ILogger<IServiceRepository> _logger;
        private readonly DbContextOptions _options;

        #endregion MEMBERS
        
        #region CONSTRUCTORS
        
        public ServiceRepository(ILogger<IServiceRepository> logger, DbContextOptions options)
        {
            _logger = logger;
            _options = options;
        }
        
        #endregion CONSTRUCTORS
        
        #region METHODS
        
        public async Task<ServiceModel> CreateAsync(ServiceCreationModel model)
        {
            var service = new ServiceModel
            {
                AccessToken = model.AccessToken,
                AuthorizeUrl = model.AuthorizeUrl,
                ServiceName = model.ServiceName,
                UrlImage = model.UrlImage,
                Widgets = model.Widgets
            };

            _logger.LogInformation($"(Service '{service.ServiceId}') Creating service model => '{JsonConvert.SerializeObject(model)}'");
            using (var context = new DashboardContext(_options))
            {
                await context.Services.AddAsync(service);
            }

            _logger.LogInformation($"(Service '{service.ServiceId}') Service model successfully created");

            return service;
        }

        public async Task DeleteAsync(Guid id)
        {
            _logger.LogInformation($"(Service '{id}') Deleting service model");

            var service = await GetAsync(id);
            using (var context = new DashboardContext(_options))
            {
                context.Services.Remove(service);
            }

            _logger.LogInformation($"(Service '{id}') Service model successfully deleted");
        }
        
        public async Task<ServiceModel> GetAsync(Guid id)
        {
            _logger.LogInformation($"(Service '{id}') Fetching service model");

            ServiceModel service;
            using (var context = new DashboardContext(_options))
            {
                service = await context.Services.AsNoTracking().SingleOrDefaultAsync(x => x.ServiceId == id);
            }

            if (service == null)
            {
                throw new NotFoundHttpException($"Service '{id}' not found");
            }

            _logger.LogInformation($"(Service '{id}') Service model successfully fetched");
            return service;
        }
        
        public async Task<IList<ServiceModel>> GetListAsync()
        {
            _logger.LogInformation("(Service list) Fetching service model list");

            List<ServiceModel> list;
            using (var context = new DashboardContext(_options))
            {
                list = await context.Services.AsNoTracking().ToListAsync();
            }

            _logger.LogInformation($"(Service list) {list.Count} models successfully fetched: {JsonConvert.SerializeObject(list)}");
            return list;
        }
        
        public async Task<IList<ServiceModel>> GetListRelationById(Guid id)
        {
            _logger.LogInformation($"(Service list) Fetching service model list with user id: {id}");
        
            List<ServiceModel> userServices;
            using (var context = new DashboardContext(_options))
            {
                userServices = await context.ServiceUser
                    .Where(su => su.UserId == id)
                    .Include(su => su.Service)
                    .Select(su => su.Service)
                    .ToListAsync();
            }
            _logger.LogInformation($"(Service list) {userServices.Count} models successfully fetched");
            return userServices;
        }

        public async Task<ServiceModel> AddServiceToUser(Guid userId, Guid serviceId)
        {
            ServiceModel serviceToAdd;
            UserModel newUser;
            _logger.LogInformation($"(Service add) {serviceId} Adding service model to user: {userId}");
            
            using (var context = new DashboardContext(_options))
            {
                serviceToAdd = await context.Services.FirstAsync(s => s.ServiceId == serviceId);
                newUser = await context.Users.FirstAsync(u => u.UserId == userId);
                
                var newServiceUser = new ServiceUserModel
                {
                    User = newUser, Service = serviceToAdd
                };
                await context.AddAsync(newServiceUser);
                await context.SaveChangesAsync();
            }
            _logger.LogInformation($"(Service Add) {serviceId} service model successfully added to user: {userId}");
            return serviceToAdd;
        }
        
        public async Task<ServiceModel> DeleteServiceFromUser(Guid serviceId, Guid userId)
        {
            _logger.LogInformation($"(Service delete) {serviceId} Deleting service model from user: {userId}");

            ServiceModel serviceToDelete;
            UserModel user;
            using (var context = new DashboardContext(_options))
            {
                serviceToDelete = await context.Services.FirstAsync(s => s.ServiceId == serviceId);
                user = await context.Users.FirstAsync(u => u.UserId == userId);
                var serviceUserToDelete = new ServiceUserModel
                {
                    User = user, Service = serviceToDelete
                };
                context.Remove(serviceUserToDelete);
                await context.SaveChangesAsync();
            }
            _logger.LogInformation($"(Service delete)  {serviceId} service model successfully deleted from user: {userId}");
            return serviceToDelete;
        }

        public async Task<bool> IsServiceAlreadyLinkedToUser(Guid serviceId, Guid userId)
        {
            using (var context = new DashboardContext(_options))
            {
                var userServices = await context.ServiceUser
                    .Where(su => su.UserId == userId)
                    .Include(su => su.Service)
                    .Select(su => su.Service)
                    .ToListAsync();
                var service = userServices.FirstOrDefault(s => s.ServiceId == serviceId);
                if (service != null)
                {
                    return true;
                }
            }
            return false;
        }
        
        
        #endregion METHODS
    }
}