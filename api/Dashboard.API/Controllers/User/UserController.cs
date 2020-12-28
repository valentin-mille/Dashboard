using System;
using System.Threading.Tasks;
using Dashboard.API.Constants;
using Microsoft.AspNetCore.Mvc;
using Dashboard.API.Models.User;
using Dashboard.API.Repositories.User;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Dashboard.API.Controllers.User
{
    [Route(ControllerConstants.UserControllerRoute)]
    [ApiController]
    public sealed class UserController : ControllerBase
    {
        #region MEMBERS
        
        private readonly IUserRepository _userRepository;
        
        private readonly ILogger<UserController> _logger;
        
        #endregion MEMBERS

        #region CONSTRUCTOR
        public UserController(IUserRepository userRepository, ILogger<UserController> logger)
        {
            _userRepository = userRepository;
            _logger = logger;
        }
        
        #endregion CONSTRUCTOR
        
        #region ROUTES
        
        [HttpGet]
        public async Task<IActionResult> GetUsersAsync()
        {
            _logger.LogInformation("(User list) User list fetch requested");

            var userList = await _userRepository.GetListAsync();
            return Ok(userList);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetUserModel([FromRoute] Guid id)
        {
            _logger.LogInformation($"Requesting user with id: {id} ...");
        
            var user = await _userRepository.GetAsync(id);
            return Ok(user);
        }
        
        [ HttpPost("signup")]
        public async Task<IActionResult> PostUserModel([FromBody] UserCreationModel userModel)
        {
            _logger.LogInformation($"(User creation) User creation requested => '{JsonConvert.SerializeObject(userModel)}'");
            var newUser = await _userRepository.CreateAsync(userModel);
            return Created($"http://{Request.Host.Value}/user/{newUser.UserId}", newUser);
        }
        
        [ HttpPost("signin")]
        public async Task<IActionResult> SignInUser([FromBody] UserModel userModel)
        {
            var user = await _userRepository.SignIn(userModel);
            return Ok(user);
        }

        // DELETE: User/5
        [HttpDelete("delete")]
        public async Task DeleteUserModel([FromBody] Guid id)
        {
            await _userRepository.DeleteAsync(id);
        }
        
        #endregion ROUTES
    }
}
