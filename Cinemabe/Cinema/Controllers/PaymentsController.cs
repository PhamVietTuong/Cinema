using Cinema.Contracts;
using Cinema.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentsController : ControllerBase
    {
        private readonly IMomoRepository _momoRepository;

        public PaymentsController(IMomoRepository momoRepository)
        {
            _momoRepository = momoRepository;
        }

        [HttpPost("CreateLinkCheckoutMomo")]
        public async Task<IActionResult> CreateLinkCheckoutMomo([FromBody] PaymentRequest paymentRequest)
        {
            try
            {
                var response = await _momoRepository.CreatePaymentAsync(paymentRequest);
                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
