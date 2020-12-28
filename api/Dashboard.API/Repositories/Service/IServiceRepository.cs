using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Dashboard.API.Models.Service;

namespace Dashboard.API.Repositories.Service
{
    public interface IServiceRepository: IRepository<ServiceModel, ServiceCreationModel>
    {
        Task<IList<ServiceModel>> GetListRelationById(Guid id);
        
        Task<ServiceModel> AddServiceToUser(Guid userId, Guid serviceId);
        
        Task<ServiceModel> DeleteServiceFromUser(Guid serviceId, Guid userId);

        Task<bool> IsServiceAlreadyLinkedToUser(Guid serviceId, Guid userId);
    }
}