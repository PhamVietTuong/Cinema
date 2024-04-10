using Cinema.Contracts;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;

namespace Cinema.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class CinemasController : ControllerBase
	{
		private readonly IUnitOfWork _uow;

		public CinemasController(IUnitOfWork uow)
		{
			_uow = uow;
		}

		#region Movie

		[HttpGet("GetMovieList")]
		public async Task<ActionResult<List<MovieViewModel>>> GetMovieList()
		{
			var result = await _uow.MovieRepository.GetMovieList();
			return Ok(result);
		}

		[HttpGet("MovieDetail/{id}")]
		public async Task<ActionResult<List<MovieViewModel>>> GetMovieDetail(Guid id)
		{
			var result = await _uow.MovieRepository.GetMovieDetail(id);
			return Ok(result);
		}

		#endregion

		#region ShowTime

		//[HttpGet("GetInformationAboutBoxOffice")]
		//public async Task<ActionResult<InformationAboutBoxOfficeViewModel>> GetInformationAboutBoxOffice(Guid showTimeId)
		//{
		//	if (!await _uow.ShowTimeRepository.Exit(showTimeId))
		//	{
		//		return NotFound();
		//	}
		//	var result = await _uow.ShowTimeRepository.GetInformationAboutBoxOffice(showTimeId);
		//	return Ok(result);
		//}

		#endregion

		#region FoodAndDrink

		[HttpGet("Combo")]
		public async Task<ActionResult<List<InformationAboutBoxOfficeViewModel>>> Combo()
		{
			var result = await _uow.FoodAndDrinkRepository.Combo();
			return Ok(result);
		}

		#endregion

		#region Ticket

		[HttpPost]
		[Authorize(Roles = "Admin")]
		public async Task<IActionResult> CreateTicket(Ticket ticket)
		{
			var checkTicket = await _uow.TicketRepository.Exist(ticket.Id);
			if (checkTicket == true)
			{
				return BadRequest();
			}
			_uow.TicketRepository.Create(ticket);

			var result = await _uow.SaveChangeAsync();

			if (!result)
			{
				return BadRequest();
			}
			return Ok();
		}

		#endregion

		#region TicketType

		[HttpGet("TicketType/{showTimeId}")]
		public async Task<ActionResult<List<TicketTypeViewModel>>> GetTicketTypeList(Guid showTimeId)
		{
			var result = await _uow.TicketTypeRepository.GetTicketTypeListAysn(showTimeId);
			return Ok(result);
		}

		#endregion
	}
}
