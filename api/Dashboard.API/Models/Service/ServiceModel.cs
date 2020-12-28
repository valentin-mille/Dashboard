using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Dashboard.API.Models.ServiceUser;
using Dashboard.API.Models.Widget;

namespace Dashboard.API.Models.Service
{
    public sealed class ServiceModel
    {
        #region CONSTRUCTORS

        public ServiceModel()
        {
            ServiceId = Guid.NewGuid();
        }

        #endregion CONSTRUCTORS
        
        #region FIELDS
        public Guid ServiceId { get; set; }

        public string ServiceName { get; set; }
        
        public string UrlImage { get; set; }
        
        public string AuthorizeUrl { get; set; }
        
        public string AccessToken { get; set; }

        public List<WidgetModel> Widgets { get; set; }

        public List<ServiceUserModel> ServiceUsers { get; set; }
        
        #endregion FIELDS
    }
}
