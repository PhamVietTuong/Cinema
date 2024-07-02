using Cinema.Contracts;
using Cinema.Data.Models;
using Cinema.DTOs;
using Cinema.Helper;
using Cinema.Repository;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Controllers
{
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private const string user = "user";
        private const string connectedRole = "user,admin";

        private readonly IUserRepository _userRepository;

        public UsersController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
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
                User user = await _userRepository.ValidateLogin(loginInfo.Username, loginInfo.Password, "user");
                if (user == null)
                {
                    return BadRequest("Thông tin chưa chính xác, đăng nhập thất bại!.");
                }

                TokenInfo token = await _userRepository.GenerateToken(loginInfo.Username, "user");
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
                User user = await _userRepository.ValidateLogin(loginInfo.Username, loginInfo.Password, "admin");
                if (user == null) { return null; }

                TokenInfo token = await _userRepository.GenerateToken(loginInfo.Username, "admin");
                return new AuthenticationResponse(user, loginInfo.Username, token.Authority, token.Token, token.ExpirationTime);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        [HttpPost("Register")]
        [ProducesResponseType(typeof(User), StatusCodes.Status201Created)]
        [ProducesResponseType(typeof(void), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(void), StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> Register([FromBody] Register model)
        {
            try
            {
                var registeredUser = await _userRepository.Register(model);

                return Ok(registeredUser);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }


        [HttpPost("SendAuthCode")]
        [AllowAnonymous]
        public async Task<IActionResult> SendAuthenticationCode(SendAuthCode sendAuthCode)
        {
            if (string.IsNullOrEmpty(sendAuthCode.Email.Trim()))
            {
                return BadRequest("Email is empty");
            }

            if (!Validate.IsEmail(sendAuthCode.Email.Trim()))
            {
                return BadRequest("Email is not valid");
            }

            var authenticationCode = await _userRepository.SendAuthenticationCode(sendAuthCode.Email.Trim());
            return authenticationCode != null ? Ok(authenticationCode) : NotFound("Not found user or send email error");

        }

        [HttpPost("ChangePassword")]
        [Authorize(Roles = user)]
        public async Task<IActionResult> ChangePassword(string changePassword, string userName)
        {
            if (string.IsNullOrEmpty(userName.Trim()) || string.IsNullOrEmpty(changePassword.Trim())) return BadRequest(" UserName or Password is empty");

            if(Validate.IsValidPassword(changePassword) == false) return BadRequest("Password is not valid");

            var result = await _userRepository.ChangePassword(changePassword, userName);
            return result ? Ok() : NotFound("Not found user");
        }

        [HttpPost("UpdateUser")]
        [Authorize(Roles = user)]
        public async Task<ActionResult<UserDTO>> UpdateUser(UserDTO entity)
        {
            try
            {
                if (!await _userRepository.ExistsAsync(entity.Id))
                {
                    return NotFound();
                }

                var result = await _userRepository.UpdateAsync(entity);

                return Ok(result);
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }
    }
}
