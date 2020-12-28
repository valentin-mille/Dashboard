using System.Threading.Tasks;
using Dashboard.API.Models.Widgets.Trump;
using Refit;

namespace Dashboard.API.Clients.Trump
{
    public interface ITrumpApiClient
    {
        [Get("/random/quote")]
        [Headers("Accept: application/json")]
        Task<TrumpQuoteWidgetModel> GetRandomQuote();
    }
}
