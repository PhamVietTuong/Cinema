using Cinema.Contracts;
using Cinema.Data.Models;
using Cinema.DTOs;
using Cinema.Helper;
using Cinema.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;


namespace Cinema.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly IUnitOfWork _uow;

        public UsersController(IUnitOfWork uow)
        {
            _uow = uow;
        }
        [HttpPost("LoginUser")]
        [ProducesResponseType(typeof(AuthenticationResponse), 200)]
        [ProducesResponseType(typeof(void), 400)]
        [ProducesResponseType(typeof(void), 401)]
        [AllowAnonymous]
        public async Task<ActionResult<AuthenticationResponse>> LoginUser([FromBody] LoginInfo loginInfo)
        {
            try
            {
                User user = await _uow.UserRepository.ValidateLogin(loginInfo.Username, loginInfo.Password, "user");
                if (user == null)
                {
                    return BadRequest("Thông tin chưa chính xác, đăng nhập thất bại!.");
                }

                TokenInfo token = await _uow.UserRepository.GenerateToken(loginInfo.Username, "user");
                return new AuthenticationResponse(user, loginInfo.Username, token.Authority, token.Token, token.ExpirationTime);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        [HttpPost("LoginAdmin")]
        [ProducesResponseType(typeof(AuthenticationResponse), 200)]
        [ProducesResponseType(typeof(void), 400)]
        [ProducesResponseType(typeof(void), 401)]
        [AllowAnonymous]
        public async Task<AuthenticationResponse> LoginAdmin([FromBody] LoginInfo loginInfo)
        {
            try
            {
                User user = await _uow.UserRepository.ValidateLogin(loginInfo.Username, loginInfo.Password, "admin");
                if (user == null) { return null; }

                TokenInfo token = await _uow.UserRepository.GenerateToken(loginInfo.Username, "admin");
                return new AuthenticationResponse(user, loginInfo.Username, token.Authority, token.Token, token.ExpirationTime);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        [HttpPost("register")]
        [ProducesResponseType(typeof(User), StatusCodes.Status201Created)]
        [ProducesResponseType(typeof(void), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(void), StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> Register([FromBody] Register model)
        {
            try
            {
                var registeredUser = await _uow.UserRepository.Register(
                    model
                );


                return Ok(registeredUser);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }


    }
}