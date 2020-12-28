using Newtonsoft.Json;

namespace Dashboard.API.Models.Widgets.Trump
{
    public sealed class TrumpQuoteWidgetModel
    {
        [JsonProperty("value")]
        public string Value { get; set; }
    }
}
