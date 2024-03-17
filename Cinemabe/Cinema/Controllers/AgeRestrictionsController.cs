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
    public class AgeRestrictionsController : ControllerBase
    {
        private readonly CinemaContext _context;

        public AgeRestrictionsController(CinemaContext context)
        {
            _context = context;
        }

        // GET: api/AgeRestrictions
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AgeRestriction>>> GetAgeRestriction()
        {
            return await _context.AgeRestrictions.ToListAsync();
        }

        // GET: api/AgeRestrictions/5
        [HttpGet("{id}")]
        public async Task<ActionResult<AgeRestriction>> GetAgeRestriction(int id)
        {
            var ageRestriction = await _context.AgeRestrictions.FindAsync(id);

            if (ageRestriction == null)
            {
                return NotFound();
            }

            return ageRestriction;
        }

        // PUT: api/AgeRestrictions/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAgeRestriction(int id, AgeRestriction ageRestriction)
        {
            if (id != ageRestriction.Id)
            {
                return BadRequest();
            }

            _context.Entry(ageRestriction).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AgeRestrictionExists(id))
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

        // POST: api/AgeRestrictions
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AgeRestriction>> PostAgeRestriction(AgeRestriction ageRestriction)
        {
            _context.AgeRestrictions.Add(ageRestriction);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetAgeRestriction", new { id = ageRestriction.Id }, ageRestriction);
        }

        // DELETE: api/AgeRestrictions/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAgeRestriction(int id)
        {
            var ageRestriction = await _context.AgeRestrictions.FindAsync(id);
            if (ageRestriction == null)
            {
                return NotFound();
            }

            _context.AgeRestrictions.Remove(ageRestriction);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AgeRestrictionExists(int id)
        {
            return _context.AgeRestrictions.Any(e => e.Id == id);
        }
    }
}
