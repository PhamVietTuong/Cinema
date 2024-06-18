using Cinema.Contracts;
using Cinema.Data.Models;
using Cinema.DTOs;
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

        [HttpPost("SendAuthCode")]
        [AllowAnonymous]
        public async Task<IActionResult> SendAuthenticationCode(string email)
        {
            if (string.IsNullOrEmpty(email.Trim()))
            {
                return BadRequest("Email is empty");
            }
            var authenticationCode = await _uow.UserRepository.SendAuthenticationCode(email.Trim());
            return authenticationCode != null ? Ok(authenticationCode) : NotFound("Không tìm thấy người dùng hoặc gửi email thất bại");

        }

        [HttpPost("ChangePassword")]
        [AllowAnonymous]
        public async Task<IActionResult> ChangePassword(string changePassword, string userName)
        {
            if (string.IsNullOrEmpty(userName.Trim()) || string.IsNullOrEmpty(changePassword.Trim())) return BadRequest(" UserName or Password is empty");

            var result = await _uow.UserRepository.ChangePassword(changePassword, userName);
            return result ? Ok() : NotFound("Không tìm thấy người dùng");
        }
    }
}
