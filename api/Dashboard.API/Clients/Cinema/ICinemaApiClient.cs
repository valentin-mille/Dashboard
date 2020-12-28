using System.Threading.Tasks;
using Dashboard.API.Models.Widgets.Cinema;
using Refit;

namespace Dashboard.API.Clients.Cinema
{
    public interface ICinemaApiClient
    {
        [Get("/?apikey={apikey}&t={title}")]
        Task<CinemaMovieWidgetModel> GetMovie(string title, string apikey);
    }
}
