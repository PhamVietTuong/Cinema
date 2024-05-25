using Cinema.Contracts;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Net;

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

		[HttpPost("MovieDetail")]
		public async Task<ActionResult<List<MovieViewModel>>> GetMovieDetail(MovieDetailDTO movieDetailDTO)
		{
			var result = await _uow.MovieRepository.GetMovieDetail(movieDetailDTO);
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

		[HttpPost("Ticket")]
		public async Task<ActionResult<List<TicketDTO>>> CreateTicket([FromBody] TicketDTO vm)
		{
			var result = await _uow.TicketRepository.CreateAysn(vm);
			return Ok(result);
		}

		#endregion

		#region Seat
		[HttpPost("SeatByShowTimeAndRoomId")]
		public async Task<ActionResult<List<SeatViewModel>>> SeatByShowTimeAndRoomId(SeatByShowTimeAndRoomDTO vm)
		{
			var result = await _uow.SeatRepository.GetSeatByShowTimeAndRoomIdAysn(vm);
			return Ok(result);
		}

		#endregion

		#region Theater

		[HttpGet("GetTheaterList")]
		public async Task<ActionResult<List<TheaterDTO>>> GetTheaterList()
		{
			var result = await _uow.TheaterRepository.GetAllTheater();

			if (result.Count == 0)
			{
				return StatusCode(StatusCodes.Status204NoContent);
			}

			return Ok(result);
		}

		//[HttpPost("GetShowTimeByDateAndTheaterId")]

		//24/05/2024 tienn: HttpPost - > HttpGet, changed api name, added 2 para in route, changed para of method
		[HttpGet("GetShowTimeByDate{date}/TheaterId{theaterId}")]
		public async Task<ActionResult<List<TheaterDTO>>> GetShowTimeByDateAndTheaterId(DateTime date, Guid theaterId)
		{
			//add line from 112 to 116
			var showTimeByDateAndTheaterId = new ShowTimeByDateAndTheaterId
			{
				Date = date,
				TheaterId = theaterId
			};

			var result = await _uow.TheaterRepository.GetShowTimeByDateAndTheaterId(showTimeByDateAndTheaterId);

			if (result.Count == 0)
			{
				return StatusCode(StatusCodes.Status204NoContent);
			}

			return Ok(result);
		}

		#endregion

		#region SeatType
		#region TicketType

		[HttpPost("GetSeatTypeTicketTypeByListSeatTypeId")]
		public async Task<ActionResult<List<SeatTypeTicketTypeRowViewModel>>> GetSeatTypeTicketTypeByListSeatTypeId(List<Guid> seatTypeIds)
		{
			var result = await _uow.SeatTypeRepository.GetSeatTypeTicketTypeByListSeatTypeId(seatTypeIds);

			if (result.Count == 0)
			{
				return StatusCode(StatusCodes.Status204NoContent);
			}

			return Ok(result);
		}
        [HttpPost("TicketTypeByShowTimeAndRoomId")]
        public async Task<ActionResult<List<TicketTypeViewModel>>> TicketTypeByShowTimeAndRoomId(TicketTypeByShowTimeAndRoomDTO vm)
        {
            var result = await _uow.TicketTypeRepository.TicketTypeByShowTimeAndRoomAysn(vm);
            return Ok(result);
        }

		#endregion
	}
}
