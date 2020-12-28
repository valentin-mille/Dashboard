using System;
using System.ComponentModel.DataAnnotations;
using Dashboard.API.Models.Service;
using Dashboard.API.Models.User;
using Newtonsoft.Json;

namespace Dashboard.API.Models.ServiceUser
{
    public class ServiceUserCreationModel
    {
        #region MEMBERS
        
        [Required]
        [JsonRequired]
        public Guid ServiceId { get; set; }
        
        public ServiceModel Service { get; set; }
        
        [Required]
        [JsonRequired]
        public Guid UserId { get; set; }
        
        public UserModel User { get; set; }
            
        #endregion MEMBERS
    }
}