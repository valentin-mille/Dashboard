using System.Collections.Generic;

namespace Dashboard.API.Models.About
{
    public class AboutServerModel
    {
        public int current_time { get; set; }

        public List<AboutServiceModel> services { get; set; }
    }
}