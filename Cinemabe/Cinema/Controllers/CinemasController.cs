using Cinema.Contracts;
using Cinema.Data.Enum;
using Cinema.Data.Models;
using Cinema.DTOs;
using Cinema.Helper;
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

        private readonly IAgeRestrictionRepository _ageRestrictionRepository;
        private readonly IFoodAndDrinkRepository _foodAndDrinkRepository;
        private readonly IInvoiceRepository _invoiceRepository;
        private readonly IMovieRepository _movieRepository;
        private readonly ISeatRepository _seatRepository;
        private readonly ITheaterRepository _theaterRepository;
        private readonly ITicketTypeRepository _ticketTypeRepository;
        private readonly IMovieTypeRepository _movieTypeRepository;
        private readonly ISeatTypeRepository _seatTypeRepository;
        private readonly IUserTypeRepository _userTypeRepository;

        public CinemasController(IAgeRestrictionRepository ageRestrictionRepository, IFoodAndDrinkRepository foodAndDrinkRepository, IInvoiceRepository invoiceRepository, IMovieRepository movieRepository,
            ISeatRepository seatRepository, ITheaterRepository theaterRepository, ITicketTypeRepository ticketTypeRepository, IMovieTypeRepository movieTypeRepository, ISeatTypeRepository seatTypeRepository,
            IUserTypeRepository userTypeRepository)
        {
            _ageRestrictionRepository = ageRestrictionRepository;
            _foodAndDrinkRepository = foodAndDrinkRepository;
            _invoiceRepository = invoiceRepository;
            _movieRepository = movieRepository;
            _seatRepository = seatRepository;
            _theaterRepository = theaterRepository;
            _ticketTypeRepository = ticketTypeRepository;
            _movieTypeRepository = movieTypeRepository;
            _seatTypeRepository = seatTypeRepository;
            _userTypeRepository = userTypeRepository;
        }

        #region Search theater, movie
        [HttpGet("SearchByName{name}")]
        [AllowAnonymous]
        public async Task<ActionResult> Search(string name)
        {

            try
            {
                var theaterResults = await _theaterRepository.GetTheatersByName(name);
                if (theaterResults != null && theaterResults.Any())
                {
                    return Ok(new { theaters = theaterResults });
                }

                var movieResults = await _movieRepository.GetMoviesByName(name);
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

        [HttpGet("GetMovieListAdmin")]
        [AllowAnonymous]
        public async Task<ActionResult<List<MovieDTO>>> GetMovieListAdmin()
        {
            try
            {
                var result = await _movieRepository.GetMoviesOriginal();
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        [HttpGet("GetMovieById/{id}")]
        [AllowAnonymous]
        public async Task<ActionResult<MovieDTO>> GetMovieById(Guid id)
        {
            try
            {
                var result = await _movieRepository.GetMovieById(id);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        [HttpPost("CreateMovie")]
        [AllowAnonymous]
        public async Task<ActionResult<MovieDTO>> CreateMovie([FromForm] MovieDTO m)
        {
            try
            {
                var result = await _movieRepository.CreateMovie(m);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }


    
        [HttpGet("GetMovieList")]
        [AllowAnonymous]
        public async Task<ActionResult<List<MovieDetailViewModel>>> GetMovieList()
        {
            try
            {
                var result = await _movieRepository.GetMovieList();
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
                var result = await _movieRepository.GetMovieDetail(movieDetailDTO);
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
                var result = await _movieRepository.GetMovieTheaterId(theaterId);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        #endregion

        #region MovieType

        [HttpGet("GetMovieTypeList")]
        [AllowAnonymous]
        public async Task<ActionResult<List<MovieTypeDTO>>> GetMovieTypeList()
        {
            try
            {
                var result = await _movieTypeRepository.GetMovieTypeListAsync();

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("UpdateMovieType")]
        [AllowAnonymous]
        public async Task<ActionResult<MovieTypeDTO>> UpdateMovieType(MovieTypeDTO entity)
        {
            try
            {
                if (!await _movieTypeRepository.ExistsAsync(entity.Id))
                {
                    return NotFound();
                }

                var result = await _movieTypeRepository.UpdateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("CreateMovieType")]
        [AllowAnonymous]
        public async Task<ActionResult<MovieTypeDTO>> CreateMovieType(MovieTypeDTO entity)
        {
            try
            {
                var result = await _movieTypeRepository.CreateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
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
                var result = await _foodAndDrinkRepository.ComboByTheaterIdAsync(id);
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
                var result = await _seatRepository.GetSeatByShowTimeAndRoomIdAysn(vm);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        #endregion

        #region SeatType

        [HttpGet("GetSeatTypeList")]
        [AllowAnonymous]
        public async Task<ActionResult<List<SeatTypeDTO>>> GetSeatTypeList()
        {
            try
            {
                var result = await _seatTypeRepository.GetSeatTypeListAsync();

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("UpdateSeatType")]
        [AllowAnonymous]
        public async Task<ActionResult<SeatTypeDTO>> UpdateSeatType(SeatTypeDTO entity)
        {
            try
            {
                if (!await _seatTypeRepository.ExistsAsync(entity.Id))
                {
                    return NotFound();
                }

                var result = await _seatTypeRepository.UpdateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("CreateSeatType")]
        [AllowAnonymous]
        public async Task<ActionResult<SeatTypeDTO>> CreateSeatType(SeatTypeDTO entity)
        {
            try
            {
                var result = await _seatTypeRepository.CreateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
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
                var result = await _theaterRepository.GetAllTheater();

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


            var result = await _theaterRepository.GetShowTimeByTheaterId(theaterId);

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
                var result = await _theaterRepository.GetTheaterAsync(id);

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

        [HttpGet("GetTheaterListAdmin")]
        [AllowAnonymous]
        public async Task<ActionResult<List<TheaterDTO>>> GetTheaterListAdmin()
        {
            try
            {
                var result = await _theaterRepository.GetTheaterListAsync();

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("UpdateTheater")]
        [AllowAnonymous]
        public async Task<ActionResult<TheaterDTO>> UpdateTheater(TheaterDTO entity)
        {
            try
            {
                if (!await _theaterRepository.ExistsAsync(entity.Id))
                {
                    return NotFound();
                }

                var result = await _theaterRepository.UpdateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("CreateTheater")]
        [AllowAnonymous]
        public async Task<ActionResult<TheaterDTO>> CreateTheater([FromForm] TheaterDTO entity)
        {
            try
            {
                var result = await _theaterRepository.CreateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
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
                var result = await _ticketTypeRepository.TicketTypeByShowTimeAndRoomAsync(vm);
                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e);
            }
        }

        [HttpGet("GetTicketTypeList")]
        [AllowAnonymous]
        public async Task<ActionResult<List<TicketTypeDTO>>> GetTicketTypeList()
        {
            try
            {
                var result = await _ticketTypeRepository.GetTicketTypeListAsync();

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("UpdateTicketType")]
        [AllowAnonymous]
        public async Task<ActionResult<TicketTypeDTO>> UpdateTicketType(TicketTypeDTO entity)
        {
            try
            {
                if (!await _ticketTypeRepository.ExistsAsync(entity.Id))
                {
                    return NotFound();
                }

                var result = await _ticketTypeRepository.UpdateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("CreateTicketType")]
        [AllowAnonymous]
        public async Task<ActionResult<TicketTypeDTO>> CreateTicketType(TicketTypeDTO entity)
        {
            try
            {
                var result = await _ticketTypeRepository.CreateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
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
                var dateRows = await _movieRepository.GetDateByMovieID(movieId, ProjectionForm);

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
                var showtimeViewModels = await _movieRepository.GetShowTimeByMovieID(movieId, date, ProjectionForm);

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
                var result = await _invoiceRepository.GetInvoiceAsync(code);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpGet("GetInvoiceList/{userId}")]
        [Authorize(Roles = user)]
        public async Task<ActionResult<InvoiceViewModel>> GetInvoiceList(Guid userId)
        {
            try
            {
                var result = await _invoiceRepository.InvoiceListOfUserAsync(userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        #endregion

        #region AgeRestriction

        [HttpGet("GetAgeRestrictionList")]
        [AllowAnonymous]
        public async Task<ActionResult<List<AgeRestrictionDTO>>> GetAgeRestrictionList()
        {
            try
            {
                var result = await _ageRestrictionRepository.GetAgeRestrictionListAsync();

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("UpdateAgeRestriction")]
        [AllowAnonymous]
        public async Task<ActionResult<AgeRestrictionDTO>> UpdateAgeRestriction(AgeRestrictionDTO entity)
        {
            try
            {
                if (!await _ageRestrictionRepository.ExistsAsync(entity.Id))
                {
                    return NotFound();
                }

                var result = await _ageRestrictionRepository.UpdateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("CreateAgeRestriction")]
        [AllowAnonymous]
        public async Task<ActionResult<AgeRestrictionDTO>> CreateAgeRestriction(AgeRestrictionDTO entity)
        {
            try
            {
                var result = await _ageRestrictionRepository.CreateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        #endregion

        #region UserType

        [HttpGet("GetUserTypeList")]
        [AllowAnonymous]
        public async Task<ActionResult<List<UserTypeDTO>>> GetUserTypeList()
        {
            try
            {
                var result = await _userTypeRepository.GetUserTypeListAsync();

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("UpdateUserType")]
        [AllowAnonymous]
        public async Task<ActionResult<UserTypeDTO>> UpdateUserType(UserTypeDTO entity)
        {
            try
            {
                if (!await _userTypeRepository.ExistsAsync(entity.Id))
                {
                    return NotFound();
                }

                var result = await _userTypeRepository.UpdateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [HttpPost("CreateUserType")]
        [AllowAnonymous]
        public async Task<ActionResult<UserTypeDTO>> CreateUserType(UserTypeDTO entity)
        {
            try
            {
                var result = await _userTypeRepository.CreateAsync(entity);

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
