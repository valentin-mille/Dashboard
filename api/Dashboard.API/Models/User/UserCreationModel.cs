using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Dashboard.API.Models.Service;
using Newtonsoft.Json;

namespace Dashboard.API.Models.User
{
    public sealed class UserCreationModel
    {
        #region FIELDS
        
        [Required]
        [JsonRequired]
        public string Username { get; set; }
        
        [Required]
        [JsonRequired]
        public string Password { get; set; }
        
        public ICollection<ServiceModel> Services { get; set; }

        #endregion FIELDS
    }
}