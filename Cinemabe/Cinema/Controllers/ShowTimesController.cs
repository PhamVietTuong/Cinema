using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.Contracts;
using Cinema.DTOs;

namespace Cinema.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ShowTimesController : ControllerBase
    {
        private readonly IUnitOfWork _uow;

        public ShowTimesController(IUnitOfWork uow)
        {
			_uow = uow;
        }

		[HttpGet("GetInformationAboutBoxOffice")]
		public async Task<ActionResult<InformationAboutBoxOfficeViewModel>> GetInformationAboutBoxOffice(int showTimeId)
        {
            if (!await _uow.ShowTimeRepository.Exit(showTimeId))
            {
                return NotFound();
            }
            var result = await _uow.ShowTimeRepository.GetInformationAboutBoxOffice(showTimeId);
            return Ok(result);
        }

	}
}
