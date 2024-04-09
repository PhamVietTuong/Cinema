using Cinema.Contracts;
using Cinema.Data;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
	public class FoodAndDrinkRepository : IFoodAndDrinkRepository
	{
		private readonly CinemaContext _context;

		public FoodAndDrinkRepository(CinemaContext context)
		{
			_context = context;
		}

		public async Task<List<ComboViewModel>> Combo()
		{
			var combos = await _context.FoodAndDrinks.ToListAsync();
			
			var rows = new List<ComboViewModel>();

			foreach (var combo in combos)
			{
				rows.Add(new ComboViewModel
				{
					Id = combo.Id,
					Name = combo.Name,
					Description = combo.Description,
					Image = combo.Image,
					Price = combo.Price,
				});
			}

			return rows;
		}
	}
}
