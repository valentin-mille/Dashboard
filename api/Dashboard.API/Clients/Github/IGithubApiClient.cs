using System.Threading.Tasks;
using Dashboard.API.Models.Github;
using Refit;

namespace Dashboard.API.Clients.Github
{
    public interface IGithubApiClient
    {
        [Get("/users/{username}/repos")]
        [Headers("Authorization: Bearer")]
        Task<GithubRepoModel> GetUserRepository(string username);
    }
}