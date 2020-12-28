using Newtonsoft.Json;

namespace  Dashboard.API.Models.Widgets.Covid
{
    public sealed class CovidDepartmentServiceModel
    {
        [JsonProperty("nom")]
        public string Country { get; set; }

        [JsonProperty("date")]
        public int Date { get; set; }

        [JsonProperty("hospitalises")]
        public int Hospitalizations { get; set; }
        
        [JsonProperty("reanimation")]
        public int IntensiveCare { get; set; }
        
        [JsonProperty("nouvellesHospitalisations")]
        public int NewHospitalizations { get; set; }
        
        [JsonProperty("nouvellesReanimations")]
        public int NewIntensiveCare { get; set; }
        
        [JsonProperty("deces")]
        public int Death { get; set; }

        [JsonProperty("gueris")]
        public int Healed { get; set; }

        [JsonProperty("sourceType")]
        public string Source { get; set; }
    }
}