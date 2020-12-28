using System.Threading.Tasks;
using Dashboard.API.Models.Widgets.Nasa;
using Refit;

namespace Dashboard.API.Clients.Nasa
{
    public interface INasaApiClient
    {
        [Get("/planetary/apod?api_key={apikey}")]
        Task<NasaApodWidgetModel> GetPicture(string apikey);
    }
}
