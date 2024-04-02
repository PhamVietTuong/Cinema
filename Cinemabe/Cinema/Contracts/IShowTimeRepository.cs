using Cinema.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Contracts
{
	public interface IShowTimeRepository
	{
		Task<bool> Exit(int id);
		Task<InformationAboutBoxOfficeViewModel> GetInformationAboutBoxOffice(int showTimeId);
	}
}
