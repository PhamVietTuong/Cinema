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
    public class MoviesController : ControllerBase
    {
        private readonly IUnitOfWork _uow;

        public MoviesController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        [HttpGet("GetMovieList")]
        public async Task<ActionResult<List<MovieViewModel>>> GetMovieList()
        {
            var result = await _uow.MovieRepository.GetMovieList();
            return Ok(result);
        }
    }
}
