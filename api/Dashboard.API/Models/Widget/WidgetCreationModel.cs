using System;
using System.ComponentModel.DataAnnotations;
using Dashboard.API.Models.Service;
using Newtonsoft.Json;

namespace Dashboard.API.Models.Widget
{
    public sealed class WidgetCreationModel
    {
        #region FIELDS

        [Required]
        [JsonRequired]
        public string WidgetName { get; set; }
        
        public string WidgetDescription { get; set; }
        
        public Guid ServiceId { get; set; }
        
        public ServiceModel Service { get; set; }

        #endregion FIELDS
    }
}