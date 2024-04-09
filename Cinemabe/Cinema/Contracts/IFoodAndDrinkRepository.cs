using Cinema.DTOs;

namespace Cinema.Contracts
{
	public interface IFoodAndDrinkRepository
	{
		Task<List<ComboViewModel>> Combo();
	}
}
