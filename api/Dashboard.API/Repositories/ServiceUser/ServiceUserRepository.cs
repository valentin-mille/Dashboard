using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Dashboard.API.Contexts;
using Dashboard.API.Exceptions.Http;
using Dashboard.API.Models.ServiceUser;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Dashboard.API.Repositories.ServiceUser
{
    public class ServiceUserRepository: IServiceUserRepository
    {
        #region MEMBERS

        private readonly ILogger<IServiceUserRepository> _logger;
        private readonly DbContextOptions _options;

        #endregion MEMBERS
        
        #region CONSTRUCTORS
        
        public ServiceUserRepository(ILogger<IServiceUserRepository> logger, DbContextOptions options)
        {
            _logger = logger;
            _options = options;
        }
        
        #endregion CONSTRUCTORS
        
        #region METHODS
        
        public async Task<ServiceUserModel> CreateAsync(ServiceUserCreationModel model)
        {
            var serviceUser = new ServiceUserModel
            {
                ServiceId = model.ServiceId,
                Service = model.Service,
                UserId = model.UserId,
                User = model.User
            };

            _logger.LogInformation($"(ServiceUser '{serviceUser.ServiceId}') Creating ServiceUser model => '{JsonConvert.SerializeObject(model)}'");
            using (var context = new DashboardContext(_options))
            {
                await context.ServiceUser.AddAsync(serviceUser);
            }

            _logger.LogInformation($"(ServiceUser '{serviceUser.ServiceId}') ServiceUser model successfully created");

            return serviceUser;
        }

        public Task DeleteAsync(Guid id)
        {
            throw new NotImplementedException();
        }

        public Task<ServiceUserModel> GetAsync(Guid id)
        {
            throw new NotImplementedException();
        }

        public async Task DeleteAsync(Guid serviceId, Guid userId)
        {
            _logger.LogInformation($"(ServiceUser '{userId}/{serviceId}') Deleting ServiceUser model");

            var serviceUser = await GetAsync(userId, serviceId);
            using (var context = new DashboardContext(_options))
            {
                context.ServiceUser.Remove(serviceUser);
            }

            _logger.LogInformation($"(ServiceUser '{userId}/{serviceId}') ServiceUser model successfully deleted");
        }
        
        public async Task<ServiceUserModel> GetAsync(Guid userId, Guid serviceId)
        {
            _logger.LogInformation($"(ServiceUser '{userId}/{serviceId}') Fetching ServiceUser model");

            ServiceUserModel serviceUser;
            using (var context = new DashboardContext(_options))
            {
                serviceUser = await context.ServiceUser
                    .AsNoTracking().
                    SingleOrDefaultAsync(x => x.ServiceId == serviceId && x.UserId == userId);
            }

            if (serviceUser == null)
            {
                throw new NotFoundHttpException($"Service '{userId}/{serviceId}' not found");
            }

            _logger.LogInformation($"(ServiceUser '{userId}/{serviceId}') ServiceUser model successfully fetched");
            return serviceUser;
        }
        
        public async Task<IList<ServiceUserModel>> GetListAsync()
        {
            _logger.LogInformation("(ServiceUser list) Fetching ServiceUser model list");

            List<ServiceUserModel> list;
            using (var context = new DashboardContext(_options))
            {
                list = await context.ServiceUser.AsNoTracking().ToListAsync();
            }

            _logger.LogInformation($"(ServiceUser list) {list.Count} models successfully fetched: {JsonConvert.SerializeObject(list)}");
            return list;
        }
        
        #endregion METHODS
    }
}