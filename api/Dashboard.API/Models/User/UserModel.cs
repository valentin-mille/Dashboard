using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Dashboard.API.Models.ServiceUser;

namespace Dashboard.API.Models.User
{
    public sealed class UserModel
    {
        #region CONSTRUCTORS

        public UserModel()
        {
            UserId = Guid.NewGuid();
        }

        #endregion CONSTRUCTORS
        
        public Guid UserId { get; set; }

        public string Username { get; set; }

        public string Password { get; set; }

        public List<ServiceUserModel> ServiceUsers { get; set; }
    }
}
