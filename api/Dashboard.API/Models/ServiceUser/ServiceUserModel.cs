using System;
using Dashboard.API.Models.Service;
using Dashboard.API.Models.User;

namespace Dashboard.API.Models.ServiceUser
{
    public class ServiceUserModel
    {
        #region MEMBERS

        public ServiceUserModel()
        {
            CreationDate = DateTime.Now;
        }
        
        public DateTime CreationDate { get; set; }
        
        public Guid ServiceId { get; set; }
        
        public ServiceModel Service { get; set; }
        
        public Guid UserId { get; set; }
        
        public UserModel User { get; set; }
            
        #endregion MEMBERS
    }
}