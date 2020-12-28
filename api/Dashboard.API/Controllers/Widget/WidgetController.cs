using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using Dashboard.API.Constants;
using Dashboard.API.Exceptions.Http;
using Dashboard.API.Models.Widget;
using Dashboard.API.Repositories.Widget;

namespace Dashboard.API.Controllers.Widget
{
    [ApiController]
    [Route(ControllerConstants.WidgetControllerRoute)]
    public sealed class WidgetController : ControllerBase
    {
        #region MEMBERS

        private readonly IWidgetRepository _widgetRepository;
        
        private readonly ILogger<WidgetController> _logger;

        #endregion MEMBERS

        #region CONSTRUCTORS

        public WidgetController(IWidgetRepository widgetRepository, ILogger<WidgetController> logger)
        {
            _widgetRepository = widgetRepository;
            _logger = logger;
        }

        #endregion CONSTRUCTORS

        #region ROUTES
        
        [HttpPut]
        public async Task<IActionResult> CreateWidgetAsync([FromBody] WidgetCreationModel model)
        {
            var widgetList = await _widgetRepository.CreateAsync(model);
            return Ok(widgetList);
        }

        [HttpGet]
        public async Task<IActionResult> GetWidgetsAsync()
        {
            var widgetList = await _widgetRepository.GetListAsync();
            return Ok(widgetList);
        }
        
        [HttpGet("{id}")]
        public async Task<IActionResult> GetWidgetById([FromBody] Guid id)
        {
            var widget = await _widgetRepository.GetAsync(id);
            return Ok(widget);
        }
        
        [HttpDelete("{id}")]
        public async Task DeleteWidgetAsync([FromRoute] Guid id)
        {
            await _widgetRepository.DeleteAsync(id);
        }

        #endregion ROUTES

    }
}