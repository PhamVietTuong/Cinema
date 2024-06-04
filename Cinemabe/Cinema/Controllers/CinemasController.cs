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

        #region Search theater, movie
        [HttpGet("SearchByName{name}")]
        public async Task<ActionResult> Search(string name)
        {

            try
            {
                var theaterResults = await _uow.TheaterRepository.GetTheatersByName(name);
                if (theaterResults != null && theaterResults.Any())
                {
                    return Ok(theaterResults);
                }

                var movieResults = await _uow.MovieRepository.GetMoviesByName(name);
                if (movieResults != null && movieResults.Any())
                {
                    return Ok(movieResults);
                }



                return NotFound(new { Message = "Không tìm thấy phim hoặc rạp chiếu phim nào." });
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { Error = e.Message });
            }
        }
        #endregion

        #region Movie

        [HttpGet("GetMovieList")]
        public async Task<ActionResult<List<MovieDetailViewModel>>> GetMovieList()
        {
            try
            {
                var result = await _uow.MovieRepository.GetMovieList();
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        [HttpPost("MovieDetail")]
        public async Task<ActionResult<List<MovieDetailViewModel>>> GetMovieDetail(MovieDetailDTO movieDetailDTO)
        {
            try
            {
                var result = await _uow.MovieRepository.GetMovieDetail(movieDetailDTO);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        [HttpGet("GetMovieTheaterId{theaterId}")]
        public async Task<ActionResult<List<MovieDetailViewModel>>> GetMovieTheaterId(Guid theaterId)
        {
            try
            {
                var result = await _uow.MovieRepository.GetMovieTheaterId(theaterId);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        #endregion

        #region FoodAndDrink

        [HttpGet("ComboByTheaterId/{id}")]
        public async Task<ActionResult<List<ComboViewModel>>> ComboByTheaterId(Guid id)
        {
            try
            {
                var result = await _uow.FoodAndDrinkRepository.ComboByTheaterIdAsync(id);
                return Ok(result);

            }

            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        #endregion

        #region Seat
        [HttpPost("SeatByShowTimeAndRoomId")]
        public async Task<ActionResult<List<SeatViewModel>>> SeatByShowTimeAndRoomId(SeatByShowTimeAndRoomDTO vm)
        {
            try
            {
                var result = await _uow.SeatRepository.GetSeatByShowTimeAndRoomIdAysn(vm);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        #endregion

        #region Theater

        [HttpGet("GetTheaterList")]
        public async Task<ActionResult<List<TheaterDTO>>> GetTheaterList()
        {
            try
            {
                var result = await _uow.TheaterRepository.GetAllTheater();

                if (result.Count == 0)
                {
                    return StatusCode(StatusCodes.Status204NoContent);
                }

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        [HttpGet("GetShowTimeByTheaterId{theaterId}")]
        public async Task<ActionResult<List<TheaterDTO>>> GetShowTimeByTheaterId(Guid theaterId)
        {


            var result = await _uow.TheaterRepository.GetShowTimeByTheaterId(theaterId);

            if (result.Count == 0)
            {
                return StatusCode(StatusCodes.Status204NoContent);
            }

            return Ok(result);
        }

        #endregion

        #region TicketType

        [HttpPost("TicketTypeByShowTimeAndRoomId")]
        public async Task<ActionResult<List<TicketTypeViewModel>>> TicketTypeByShowTimeAndRoomId(TicketTypeByShowTimeAndRoomDTO vm)
        {
            try
            {
                var result = await _uow.TicketTypeRepository.TicketTypeByShowTimeAndRoomAysn(vm);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        #endregion

        #region Date
        [HttpGet("GetDateByMovieId/{movieId}/{ProjectionForm}")]
        public async Task<ActionResult<List<DateTime>>> GetDateByMovieID(Guid movieId, int ProjectionForm)
        {
            try
            {
                var dateRows = await _uow.MovieRepository.GetDateByMovieID(movieId, ProjectionForm);

                if (dateRows == null)
                {
                    return NotFound();
                }

                return Ok(dateRows);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }
        #endregion

        #region ShowtimeByDate
        [HttpGet("GetShowTimeByMovieID/{movieId}/{date}/{ProjectionForm}")]
        public async Task<ActionResult<List<ShowTimeRowViewModel>>> GetShowTimeByMovieID(Guid movieId, DateTime date, int ProjectionForm)
        {
            try
            {
                var showtimeViewModels = await _uow.MovieRepository.GetShowTimeByMovieID(movieId, date, ProjectionForm);

                if (showtimeViewModels == null || !showtimeViewModels.Any())
                {
                    return NotFound();
                }

                return Ok(showtimeViewModels);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }
        #endregion
    }
}
