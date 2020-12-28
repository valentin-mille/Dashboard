using Newtonsoft.Json;

namespace Dashboard.API.Models.Widgets.Movie
{
    public sealed class MovieWidgetModel
    {
        [JsonProperty("page")]
        public string Overview { get; set; }
        
        [JsonProperty("results")]
        public MovieServiceInfoModel[] MovieDataList { get; set; }
    }
}