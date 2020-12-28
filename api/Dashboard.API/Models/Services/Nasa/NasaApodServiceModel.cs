using Newtonsoft.Json;

namespace Dashboard.API.Models.Widgets.Nasa
{
    public sealed class NasaApodWidgetModel
    {
        [JsonProperty("title")]
        public string Title { get; set; }

        [JsonProperty("url")]
        public string Url { get; set; }
    }
}
