using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Dashboard.API.Contexts;
using Dashboard.API.Exceptions.Http;
using Dashboard.API.Models.Widget;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Dashboard.API.Repositories.Widget
{
    public sealed class WidgetRepository: IWidgetRepository
    {
        #region MEMBERS

        private readonly ILogger<IWidgetRepository> _logger;
        private readonly DbContextOptions _options;

        #endregion MEMBERS
        
        #region CONSTRUCTORS
        
        public WidgetRepository(ILogger<IWidgetRepository> logger, DbContextOptions options)
        {
            _logger = logger;
            _options = options;
        }
        
        #endregion CONSTRUCTORS

        #region METHODS
        
        public async Task<WidgetModel> CreateAsync(WidgetCreationModel model)
        {
            var widget = new WidgetModel
            {
                WidgetName = model.WidgetName,
                WidgetDescription = model.WidgetDescription,
                ServiceId = model.ServiceId,
                Service = model.Service,
            };

            _logger.LogInformation($"(Widget '{widget.WidgetId}') Creating widget model => '{JsonConvert.SerializeObject(model)}'");
            using (var context = new DashboardContext(_options))
            {
                await context.Widgets.AddAsync(widget);
            }

            _logger.LogInformation($"(Widget '{widget}') Widget model successfully created");

            return widget;
        }

        public async Task DeleteAsync(Guid id)
        {
            _logger.LogInformation($"(Widget '{id}') Deleting widget model");

            var widget = await GetAsync(id);
            using (var context = new DashboardContext(_options))
            {
                context.Widgets.Remove(widget);
            }

            _logger.LogInformation($"(Widget '{id}') Widget model successfully deleted");
        }

        public async Task<WidgetModel> GetAsync(Guid id)
        {
            _logger.LogInformation($"(Widget '{id}') Fetching widget model");

            WidgetModel widget;
            using (var context = new DashboardContext(_options))
            {
                widget = await context.Widgets.AsNoTracking().SingleOrDefaultAsync(x => x.WidgetId == id);
            }

            if (widget == null)
            {
                throw new NotFoundHttpException($"Widget '{id}' not found");
            }

            _logger.LogInformation($"(Widget '{id}') Widget model successfully fetched");
            return widget;
        }
        
        public async Task<IList<WidgetModel>> GetListAsync()
        {
            _logger.LogInformation("(Widget list) Fetching widget model list");

            List<WidgetModel> list;
            using (var context = new DashboardContext(_options))
            {
                list = await context.Widgets.AsNoTracking().ToListAsync();
            }

            _logger.LogInformation($"(Widget list) {list.Count} models successfully fetched: {JsonConvert.SerializeObject(list)}");
            return list;
        }
        
        public async Task<IList<WidgetModel>> GetListRelationById(Guid id)
        {
            return await GetListAsync();
        }
        
        #endregion METHODS
    }
}