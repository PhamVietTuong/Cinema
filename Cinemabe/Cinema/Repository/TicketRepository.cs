using AutoMapper;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;
using System.Net.Sockets;

namespace Cinema.Repository
{
    public class TicketRepository : ITicketRepository
	{
		private readonly CinemaContext _context;
		private readonly IMapper _mapper;

        public TicketRepository(CinemaContext context, IMapper mapper)
		{
			_context = context;
            _mapper = mapper;
        }

        public async Task<List<TicketDTO>> CreateAysn(TicketDTO entity)
        {
            var ticketDTOs = new List<TicketDTO>();

            foreach (var seatId in entity.SeatIds)
            {
                var ticket = await _context.Ticket.AddAsync(new Ticket
                {
                    ShowTimeId = entity.ShowTimeId,
                    UserId = entity.UserId,
                    SeatId = seatId,
                    CreationTime = DateTime.UtcNow
                });

                await _context.SaveChangesAsync();

                var ticketDto = _mapper.Map<TicketDTO>(ticket.Entity);
                ticketDTOs.Add(ticketDto);
            }

            return ticketDTOs;
        }
}
}
