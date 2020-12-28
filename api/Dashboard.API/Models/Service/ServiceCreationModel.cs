using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Dashboard.API.Models.User;
using Dashboard.API.Models.Widget;
using Newtonsoft.Json;

namespace Dashboard.API.Models.Service
{
    public sealed class ServiceCreationModel
    {
        #region FIELDS
        
        [Required]
        [JsonRequired]
        public string ServiceName { get; set; }

        public string UrlImage { get; set; }
        
        public string AuthorizeUrl { get; set; }
        
        public string AccessToken { get; set; }
        
        public List<WidgetModel> Widgets { get; set; }
        
        public ICollection<UserModel> Users { get; set; }

        #endregion FIELDS
    }
}