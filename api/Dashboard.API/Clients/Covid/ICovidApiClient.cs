using System.Threading.Tasks;
using Refit;

namespace Dashboard.API.Clients.Covid
{
    public interface ICovidApiClient
    {
        [Get("/FranceLiveGlobalData")]
        Task<string> GetCovidStats();
        [Get("/LiveDataByDepartement?Departement={department}")]
        Task<string> GetCovidStatsByDepartment(string department);
    }
}
