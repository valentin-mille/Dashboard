using System;
using System.IO;
using System.Linq;

namespace Dashboard.API.Models.About
{
    public class AboutModel
    {

        private AboutClientModel client { get; set; }
        
        private AboutServerModel server { get; set; }

        public AboutModel(string servicesPath)
        {
            FetchAboutJson(servicesPath);
        }

        private void FetchAboutJson(string servicesPath)
        {
            try
            {
                var results = Directory.GetDirectories(servicesPath);
                server = new AboutServerModel();
                foreach (string result in results)
                {
                    Console.Write($"Directory: {result}\n");
                    string[] directoriesNames = result.Split(Path.DirectorySeparatorChar);
                    server.services.Add(new AboutServiceModel(directoriesNames.Last()));
                    Console.Write($"Name: {directoriesNames.Last()}\n");
                }
            } catch (ArgumentException e)
            {
                Console.Write($"Error with Weather API. Details: {e}");
                throw;
            }
        }
    }
}