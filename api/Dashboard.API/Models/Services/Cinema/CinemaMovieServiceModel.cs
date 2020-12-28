using Newtonsoft.Json;

namespace Dashboard.API.Models.Widgets.Cinema
{
    public sealed class CinemaMovieWidgetModel
    {
        [JsonProperty("Title")]
        public string Title { get; set; }

        [JsonProperty("Year")]
        public string Year { get; set; }

        [JsonProperty("Released")]
        public string Released { get; set; }

        [JsonProperty("Runtime")]
        public string Runtime { get; set; }

        [JsonProperty("Genre")]
        public string Genre { get; set; }

        [JsonProperty("Director")]
        public string Director { get; set; }

        [JsonProperty("Actors")]
        public string Actors { get; set; }

        [JsonProperty("Awards")]
        public string Awards { get; set; }

        [JsonProperty("imdbRating")]
        public float imdbRating { get; set; }
    }
}
