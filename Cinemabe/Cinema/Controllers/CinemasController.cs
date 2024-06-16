using Cinema.Contracts;
using Cinema.Data.Enum;
using Cinema.DTOs;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using AuthorizeAttribute = Microsoft.AspNetCore.Authorization.AuthorizeAttribute;

namespace Cinema.Controllers
{
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    public class CinemasController : ControllerBase
    {
        private const string user = "user";
        private const string connectedRole = "user,admin";

        private readonly IUnitOfWork _uow;

        public CinemasController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        #region Search theater, movie
        [HttpGet("SearchByName{name}")]
        [AllowAnonymous]
        public async Task<ActionResult> Search(string name)
        {

            try
            {
                var theaterResults = await _uow.TheaterRepository.GetTheatersByName(name);
                if (theaterResults != null && theaterResults.Any())
                {
                    return Ok(new { theaters =theaterResults});
                }

                var movieResults = await _uow.MovieRepository.GetMoviesByName(name);
                if (movieResults != null && movieResults.Any())
                {
                    return Ok(new { movies = movieResults });
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
        [AllowAnonymous]
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
        [AllowAnonymous]
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
        [AllowAnonymous]
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
        [AllowAnonymous]
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
        [AllowAnonymous]
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
        [AllowAnonymous]
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
        [AllowAnonymous]
        public async Task<ActionResult<List<MovieDetailViewModel>>> GetShowTimeByTheaterId(Guid theaterId)
        {


            var result = await _uow.TheaterRepository.GetShowTimeByTheaterId(theaterId);

            if (result.Count == 0)
            {
                return StatusCode(StatusCodes.Status204NoContent);
            }

            return Ok(result);
        }

        [HttpGet("GetTheater/{id}")]
        [AllowAnonymous]
        public async Task<ActionResult<TheaterDTO>> GetTheater(Guid id)
        {
            try
            {
                var result = await _uow.TheaterRepository.GetTheaterAsync(id);

                if (result == null)
                {
                    return NotFound();
                }

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        #endregion

        #region TicketType

        [HttpPost("TicketTypeByShowTimeAndRoomId")]
        [AllowAnonymous]
        public async Task<ActionResult<List<TicketTypeViewModel>>> TicketTypeByShowTimeAndRoomId(TicketTypeByShowTimeAndRoomDTO vm)
        {
            try
            {
                var result = await _uow.TicketTypeRepository.TicketTypeByShowTimeAndRoomAsync(vm);
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
        [AllowAnonymous]
        public async Task<ActionResult<List<DateTime>>> GetDateByMovieID(Guid movieId, ProjectionForm ProjectionForm)
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
        [AllowAnonymous]
        public async Task<ActionResult<List<ShowTimeRowViewModel>>> GetShowTimeByMovieID(Guid movieId, DateTime date, ProjectionForm ProjectionForm)
        {
            try
            {
                var showtimeViewModels = await _uow.MovieRepository.GetShowTimeByMovieID(movieId, date, ProjectionForm);

                return Ok(showtimeViewModels);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        #endregion

        #region Invoice

        [HttpGet("GetInvoice/{code}")]
        [Authorize(Roles = user)]
        public async Task<ActionResult<InvoiceViewModel>> GetInvoice(string code)
        {
            try
            {
                var result = await _uow.InvoiceRepository.GetInvoiceAsync(code);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        #endregion
    }
}
