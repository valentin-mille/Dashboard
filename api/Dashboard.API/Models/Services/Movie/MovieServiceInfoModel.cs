using Newtonsoft.Json;

namespace Dashboard.API.Models.Widgets.Movie
{
    public sealed class MovieServiceInfoModel
    {
        [JsonProperty("overview")]
        public string Overview { get; set; }
        
        [JsonProperty("release_date")]
        public string ReleaseDate { get; set; }
        
        [JsonProperty("title")]
        public string MovieTitle { get; set; }
        
        [JsonProperty("name")]
        public string SerieName { get; set; }

        [JsonProperty("original_language")]
        public string OriginalLanguage { get; set; }
        
        [JsonProperty("poster_path")]
        public string PosterUrl { get; set; }
        
        [JsonProperty("backdrop_path")]
        public string BackdropUrl { get; set; }

        [JsonProperty("media_type")]
        public string MediaType { get; set; }
    }
}