using Dashboard.API.Models.ServiceUser;

namespace Dashboard.API.Repositories.ServiceUser
{
    public interface IServiceUserRepository: IRepository<ServiceUserModel, ServiceUserCreationModel>
    {
        
    }
}