using Newtonsoft.Json;

namespace Dashboard.API.Models.Github
{
    public sealed class GithubRepoModel
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
    }
}