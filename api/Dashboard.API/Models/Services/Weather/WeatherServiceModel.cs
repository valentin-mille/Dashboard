using Newtonsoft.Json;

namespace Dashboard.API.Models.Widgets.Weather
{
    public sealed class Main
    {
        [JsonProperty("temp")]
        public float temp { get; set; }
        [JsonProperty("feels_like")]
        public float feels_like { get; set; }
        [JsonProperty("temp_min")]
        public float temp_min { get; set; }
        [JsonProperty("temp_max")]
        public float temp_max { get; set; }
        [JsonProperty("pressure")]
        public float pressure { get; set; }
        [JsonProperty("humidity")]
        public int humidity { get; set; }
    }

    public sealed class WeatherWidgetModel
    {
        [JsonProperty("main")]
        public Main main { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
    }
}
