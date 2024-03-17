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
    public class ChairTypesController : ControllerBase
    {
        private readonly CinemaContext _context;

        public ChairTypesController(CinemaContext context)
        {
            _context = context;
        }

        // GET: api/ChairTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ChairType>>> GetChairType()
        {
            return await _context.ChairTypes.ToListAsync();
        }

        // GET: api/ChairTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ChairType>> GetChairType(int id)
        {
            var chairType = await _context.ChairTypes.FindAsync(id);

            if (chairType == null)
            {
                return NotFound();
            }

            return chairType;
        }

        // PUT: api/ChairTypes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutChairType(int id, ChairType chairType)
        {
            if (id != chairType.Id)
            {
                return BadRequest();
            }

            _context.Entry(chairType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ChairTypeExists(id))
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

        // POST: api/ChairTypes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ChairType>> PostChairType(ChairType chairType)
        {
            _context.ChairTypes.Add(chairType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetChairType", new { id = chairType.Id }, chairType);
        }

        // DELETE: api/ChairTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteChairType(int id)
        {
            var chairType = await _context.ChairTypes.FindAsync(id);
            if (chairType == null)
            {
                return NotFound();
            }

            _context.ChairTypes.Remove(chairType);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ChairTypeExists(int id)
        {
            return _context.ChairTypes.Any(e => e.Id == id);
        }
    }
}
