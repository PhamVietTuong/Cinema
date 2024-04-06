using Cinema.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace Cinema.Contracts
{
	public interface IShowTimeRepository
	{
		Task<bool> Exit(Guid id);
		Task<InformationAboutBoxOfficeViewModel> GetInformationAboutBoxOffice(Guid showTimeId);
	}
}
