using System.Collections.Generic;

namespace Dashboard.API.Models.About
{
    public class AboutServiceModel
    {
        public string name { get; set; }
        
        public List<AboutWidgetModel> widgets { get; set; }
        
        
        #region CONSTRUCTOR
        public AboutServiceModel(string name)
        {
            this.name = name;
        }
            
        #endregion CONSTRUCTOR
    }
}