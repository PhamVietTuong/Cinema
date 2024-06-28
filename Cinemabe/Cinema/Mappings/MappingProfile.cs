using AutoMapper;
using Cinema.Data.Models;
using Cinema.DTOs;

namespace Cinema.Mappings
{
	public class MappingProfile : Profile
	{
		public MappingProfile() {
            //CreateMap<InvoiceTicket, InvoiceDTO>()
            //	.ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            //	.ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
            //	.ForMember(dest => dest.SeatIds, opt => opt.MapFrom(src => new List<Guid> { src.SeatId }));
            CreateMap<AgeRestriction, AgeRestrictionDTO>().ReverseMap();
            CreateMap<TicketType, TicketTypeDTO>().ReverseMap();
            CreateMap<MovieType, MovieTypeDTO>().ReverseMap();
        }
    }
}
