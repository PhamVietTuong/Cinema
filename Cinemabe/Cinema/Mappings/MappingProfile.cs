using AutoMapper;
using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Mappings
{
	public class MappingProfile : Profile
	{
		public MappingProfile() {
			CreateMap<Invoice, BookingDTO>()
				.ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
				.ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
				.ForMember(dest => dest.SeatIds, opt => opt.Ignore())
				.ForMember(dest => dest.FoodAndDrinkIds, opt => opt.Ignore());
		}
	}
}
