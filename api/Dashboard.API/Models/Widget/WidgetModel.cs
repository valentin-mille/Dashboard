using System;
using Dashboard.API.Models.Service;

namespace Dashboard.API.Models.Widget
{
    public sealed class WidgetModel
    {
        #region CONSTRUCTORS
        public WidgetModel()
        {
            WidgetId = Guid.NewGuid();
        }
        
        #endregion CONSTRUCTORS
        
        #region FIELDS
        
        public Guid WidgetId { get; set; }

        public string WidgetName { get; set; }

        public string WidgetDescription { get; set; }

        public Guid ServiceId { get; set; }

        public ServiceModel Service { get; set; }
        
        #endregion FIELDS
    }
}