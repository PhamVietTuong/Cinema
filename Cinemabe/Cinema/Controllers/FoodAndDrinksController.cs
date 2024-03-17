using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Cinema.Data;
using Cinema.Data.Models;

namespace Cinema.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FoodAndDrinksController : ControllerBase
    {
        private readonly CinemaContext _context;

        public FoodAndDrinksController(CinemaContext context)
        {
            _context = context;
        }

        // GET: api/FoodAndDrinks
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FoodAndDrink>>> GetFoodAndDrink()
        {
            return await _context.FoodAndDrinks.ToListAsync();
        }

        // GET: api/FoodAndDrinks/5
        [HttpGet("{id}")]
        public async Task<ActionResult<FoodAndDrink>> GetFoodAndDrink(int id)
        {
            var foodAndDrink = await _context.FoodAndDrinks.FindAsync(id);

            if (foodAndDrink == null)
            {
                return NotFound();
            }

            return foodAndDrink;
        }

        // PUT: api/FoodAndDrinks/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFoodAndDrink(int id, FoodAndDrink foodAndDrink)
        {
            if (id != foodAndDrink.Id)
            {
                return BadRequest();
            }

            _context.Entry(foodAndDrink).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FoodAndDrinkExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/FoodAndDrinks
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<FoodAndDrink>> PostFoodAndDrink(FoodAndDrink foodAndDrink)
        {
            _context.FoodAndDrinks.Add(foodAndDrink);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetFoodAndDrink", new { id = foodAndDrink.Id }, foodAndDrink);
        }

        // DELETE: api/FoodAndDrinks/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFoodAndDrink(int id)
        {
            var foodAndDrink = await _context.FoodAndDrinks.FindAsync(id);
            if (foodAndDrink == null)
            {
                return NotFound();
            }

            _context.FoodAndDrinks.Remove(foodAndDrink);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool FoodAndDrinkExists(int id)
        {
            return _context.FoodAndDrinks.Any(e => e.Id == id);
        }
    }
}
