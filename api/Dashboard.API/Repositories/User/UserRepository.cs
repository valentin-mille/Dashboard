using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Dashboard.API.Contexts;
using Dashboard.API.Exceptions.Http;
using Dashboard.API.Models.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Dashboard.API.Repositories.User
{
    public class UserRepository: IUserRepository
    {
        #region MEMBERS

        private readonly ILogger<IUserRepository> _logger;
        private readonly DbContextOptions _options;

        #endregion MEMBERS
        
        #region CONSTRUCTORS
        
        public UserRepository(ILogger<IUserRepository> logger, DbContextOptions options)
        {
            _logger = logger;
            _options = options;
        }
        
        #endregion CONSTRUCTORS

        #region METHODS
        
        public async Task<UserModel> CreateAsync(UserCreationModel model)
        {
            var user = new UserModel
            {
                Username = model.Username,
                Password = model.Password,
            };

            _logger.LogInformation($"(User '{user.UserId}') Creating user model => '{JsonConvert.SerializeObject(model)}'");
            using (var context = new DashboardContext(_options))
            {
                await context.Users.AddAsync(user);
            }

            _logger.LogInformation($"(User '{user.UserId}') User model successfully created");

            return user;
        }

        public async Task DeleteAsync(Guid id)
        {
            _logger.LogInformation($"(User '{id}') Deleting user model");

            var element = await GetAsync(id);
            using (var context = new DashboardContext(_options))
            {
                context.Users.Remove(element);
            }

            _logger.LogInformation($"(User '{id}') User model successfully deleted");
        }
        
        public async Task<UserModel> GetAsync(Guid id)
        {
            _logger.LogInformation($"(User '{id}') Fetching user model");

            UserModel user;
            using (var context = new DashboardContext(_options))
            {
                user = await context.Users.AsNoTracking().SingleOrDefaultAsync(x => x.UserId == id);
            }

            if (user == null)
            {
                throw new NotFoundHttpException($"User '{id}' not found");
            }

            _logger.LogInformation($"(User '{id}') User model successfully fetched");
            return user;
        }
        
        public async Task<IList<UserModel>> GetListAsync()
        {
            _logger.LogInformation("(User list) Fetching user model list");

            List<UserModel> list;
            using (var context = new DashboardContext(_options))
            {
                list = await context.Users.AsNoTracking().ToListAsync();
            }

            _logger.LogInformation($"(User list) {list.Count} models successfully fetched: {JsonConvert.SerializeObject(list)}");
            return list;
        }
        
        public async Task<IList<UserModel>> GetListRelationById(Guid id)
        {
            return await GetListAsync();
        }

        public async Task<UserModel> SignIn(UserModel user)
        {
            _logger.LogInformation($"(User '{user.Username}') sign in user model");

            UserModel signInUser;
            using (var context = new DashboardContext(_options))
            {
                signInUser =
                    await context.Users.FirstAsync(u =>
                        u.Username == user.Username && u.Password == user.Password);
            }
            return signInUser;
        }

        #endregion METHODS
    }
}