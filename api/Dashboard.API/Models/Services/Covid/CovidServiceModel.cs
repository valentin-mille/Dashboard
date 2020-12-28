using Newtonsoft.Json;

namespace Dashboard.API.Models.Widgets.Covid
{
    public sealed class CovidWidgetModel
    {
        [JsonProperty("date")]
        public int Date { get; set; }
        
        [JsonProperty("sourceType")]
        public string Source { get; set; }
        
        [JsonProperty("casConfirmes")]
        public int ConfirmedCases { get; set; }
        
        [JsonProperty("deces")]
        public int Death { get; set; }
        
        [JsonProperty("hospitalises")]
        public int Hospitalizations { get; set; }
        
        [JsonProperty("reanimation")]
        public int IntensiveCare { get; set; }
        
        [JsonProperty("gueris")]
        public int Healed { get; set; }
        
        [JsonProperty("nouvellesHospitalisations")]
        public int NewHospitalizations { get; set; }
        
        [JsonProperty("nouvellesReanimations")]
        public int NewIntensiveCare { get; set; }
        
        [JsonProperty("nom")]
        public string Country { get; set; }
    }
}
