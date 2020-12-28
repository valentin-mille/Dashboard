using System.Threading.Tasks;
using Dashboard.API.Models.Widgets.Movie;
using Refit;

namespace Dashboard.API.Clients.Movie
{
    public interface IMovieApiClient
    {
        [Get("/{mediaType}/{timeWindow}?api_key={apiKey}")]
        Task<MovieWidgetModel> GetMovieTrend(string mediaType, string timeWindow, string apiKey);
    }
}
