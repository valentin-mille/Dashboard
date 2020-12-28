using System.Collections.Generic;

namespace Dashboard.API.Models.About
{
    public class AboutWidgetModel
    {
        public string name { get; set; }
        
        public string description { get; set; }
        
        public List<AboutParamsModel> array { get; set; }
    }
}