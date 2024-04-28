using AutoMapper;
using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Mappings
{
	public class MappingProfile : Profile
	{
		public MappingProfile() {
			CreateMap<Ticket, TicketDTO>()
				.ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
				.ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
				.ForMember(dest => dest.SeatIds, opt => opt.MapFrom(src => new List<Guid> { src.SeatId }));
        }
	}
}
