using System.Threading.Tasks;
using Dashboard.API.Models.User;

namespace Dashboard.API.Repositories.User
{
    public interface IUserRepository: IRepository<UserModel, UserCreationModel>
    {
        Task<UserModel> SignIn(UserModel user);
    }
}