using System.Drawing.Printing;
using System.Linq;
using AutoMapper;
using Cinema.Contracts;
using Cinema.Data;
using Cinema.Data.Enum;
using Cinema.Data.Models;
using Cinema.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Cinema.Repository
{
    public class TheaterRepository : ITheaterRepository
    {
        private readonly CinemaContext _context;
        private readonly IMapper _mapper;

        public TheaterRepository(CinemaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<TheaterDTO>> GetAllTheater()
        {
            var theaters = await _context.Theater.Where(x => x.Status).OrderBy(x => x.Name).ToListAsync();
            var result = new List<TheaterDTO>();

            foreach (var theater in theaters)
            {
                result.Add(new TheaterDTO
                {
                    Id = theater.Id,
                    Name = theater.Name,
                    Address = theater.Address,
                    Image = theater.Image,
                    Phone = theater.Phone,
                });
            }

            return result;
        }

        public async Task<List<MovieDetailViewModel>> GetShowTimeByTheaterId(Guid theaterId)
        {
            var showTimeRooms = await _context.ShowTimeRoom
            .Include(x => x.Room)
            .ThenInclude(x => x.Theater)
            .Include(x => x.ShowTime)
                .ThenInclude(x => x.Movie)
                    .ThenInclude(m => m.AgeRestriction)
            .Where(x => x.Room.TheaterId == theaterId && x.ShowTime.Status == true)
            .ToListAsync();

            var movies = showTimeRooms.Select(sRoom => sRoom.ShowTime.Movie).Distinct().ToList();

            var movieAndType = movies.Select(m => new
            {
                movie = m,
                types = _context.MovieTypeDetail
                    .Include(mtd => mtd.MovieType).Where(mtd => mtd.MovieId == m.Id).ToList(),
                showTimes = showTimeRooms
                    .Where(sRoom => sRoom.ShowTime.MovieId == m.Id)
                    .ToList()
            }).ToList();



            var rows = new List<MovieDetailViewModel>();
            foreach (var item in movieAndType)
            {
                void addMovie(int time, ProjectionForm form)
                {
                    var schedules = item.showTimes
                            .Where(sRoom => sRoom.ShowTime.ProjectionForm == form)
                            .GroupBy(sRoom => sRoom.ShowTime.StartTime.Date)
                            .Select(st => new ScheduleRowViewModel
                            {
                                Date = st.Key,
                                Theaters = st.GroupBy(x => new { x.Room.Theater.Name, x.Room.Theater.Address, x.Room.TheaterId })
                                .Select(x => new TheaterRowViewModel
                                {
                                    TheaterId = x.Key.TheaterId,
                                    TheaterAddress = x.Key.Address,
                                    TheaterName = x.Key.Name,
                                    ShowTimes = x.Select(showtime =>
                                    {
                                        bool isDulexe = _context.Seat.Include(x => x.SeatType).Where(x => x.RoomId == showtime.RoomId).Any(x => x.SeatType.Name == "Nằm");
                                        return new ShowTimeRowViewModel
                                        {
                                            RoomId = showtime.Room.Id,
                                            RoomName = showtime.Room.Name,
                                            ShowTimeId = showtime.ShowTime.Id,
                                            StartTime = showtime.ShowTime.StartTime,
                                            EndTime = showtime.ShowTime.EndTime,
                                            ShowTimeType = isDulexe ? ShowTimeType.Deluxe : ShowTimeType.Standard
                                        };
                                    }).ToList()

                                }).ToList(),
                            }).ToList();

                    bool isSpecial = item.movie.ReleaseDate > DateTime.Now && schedules.Any();

                    rows.Add(new MovieDetailViewModel
                    {
                        Id = item.movie.Id,
                        AgeRestrictionName = item.movie.AgeRestriction.Name,
                        AgeRestrictionDescription = item.movie.AgeRestriction.Description,
                        AgeRestrictionAbbreviation = item.movie.AgeRestriction.Abbreviation,
                        Name = item.movie.Name,
                        Image = item.movie.Image,
                        Time = time,
                        ReleaseDate = item.movie.ReleaseDate,
                        Description = item.movie.Description,
                        Director = item.movie.Director,
                        Actor = item.movie.Actor,
                        Trailer = item.movie.Trailer,
                        Languages = item.movie.Languages,
                        MovieType = String.Join(", ", item.types.Select(type => type.MovieType.Name)),
                        ShowTimeTypeName = form == ProjectionForm.Time2D ? "2D" : "3D",
                        ProjectionForm = (int)form,
                        IsSpecial = isSpecial,
                        Schedules = schedules

                    });
                }
                if (item.movie.Time2D != -1)
                {
                    addMovie(item.movie.Time2D ?? 0, ProjectionForm.Time2D);
                }
                if (item.movie.Time3D != -1)
                {
                    addMovie(item.movie.Time3D ?? 0, ProjectionForm.Time3D);
                }

            }
            return rows;
        }

        public async Task<List<TheaterDTO>> GetTheatersByName(string name)
        {
            var input = name.Trim().ToLower().RemoveDiacritics();
            var theaters = await _context.Theater.Where(x => x.Status == true).Select(x => new TheaterDTO
            {
                Id = x.Id,
                Address = x.Address,
                Image = x.Image,
                Name = x.Name,
                Phone = x.Phone,
                Status = x.Status,
                CountRoom = _context.Room.Count(r => r.TheaterId == x.Id && r.Status == RoomStatus.Active),
                CountSeat = _context.Seat.Count(s => s.Room.TheaterId == x.Id && s.IsSeat == true)
            }).ToListAsync();

            var filteredTheaters = theaters.Where(x => x.Name.ToLower().RemoveDiacritics().Contains(input)).ToList();
            return filteredTheaters;
        }

        public async Task<TheaterDTO> GetTheaterAsync(Guid id)
        {
            var theater = await _context.Theater.FirstOrDefaultAsync(x => x.Id == id);
            var resultDto = _mapper.Map<TheaterDTO>(theater);
            var rooms = await _context.Room.Where(x => x.TheaterId == theater.Id).OrderBy(x => x.Name).ToListAsync();
            foreach (var room in rooms)
            {
                var roomDto = _mapper.Map<RoomDTO>(room);
                var seats = await _context.Seat
                    .Where(x => x.RoomId == room.Id)
                    .ToListAsync();

                var groupedSeats = seats
                    .GroupBy(x => x.RowName)
                    .ToList();

                var rowNameViewModels = groupedSeats
                    .Select(rowNameViewModel =>
                    {
                        var sortedSeats = rowNameViewModel.OrderBy(x => x.ColIndex).ToList();
                        return new RowNameViewModel
                        {
                            RowName = rowNameViewModel.Key,
                            RowSeats = sortedSeats.Select(rowSeatViewModel =>
                            {
                                return new RowSeatViewModel
                                {
                                    RowName = rowSeatViewModel.RowName,
                                    ColIndex = rowSeatViewModel.ColIndex,
                                    IsSeat = rowSeatViewModel.IsSeat,
                                    SeatTypeId = rowSeatViewModel.SeatTypeId,
                                    SeatTypeName = rowSeatViewModel.SeatType?.Name,
                                };
                            }).ToList()
                        };
                    }).OrderBy(x => x.RowName).ToList();

                roomDto.RowName = rowNameViewModels;
                resultDto.Rooms.Add(roomDto);
            }

            return resultDto;
        }

        public async Task<List<TheaterDTO>> GetTheaterListAsync()
        {
            var theaters = await _context.Theater.ToListAsync();

            var result = new List<TheaterDTO>();
            foreach (var theater in theaters)
            {
                result.Add(new TheaterDTO
                {
                    Id = theater.Id,
                    Name = theater.Name,
                    Address = theater.Address,
                    Image = theater.Image,
                    Phone = theater.Phone,
                    Status = theater.Status,
                });
            }

            return result;
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.Theater.AnyAsync(x => x.Id == id);
        }

        private async Task<RoomStatus> CheckShowTimeOfRoom( Guid roomId)
        {
            bool hasShowTime = await _context.ShowTimeRoom
                .Include(x => x.ShowTime)
                .AnyAsync(x => x.ShowTime.Status && x.RoomId == roomId);
            return hasShowTime ? RoomStatus.WaitForCancellation : RoomStatus.Cancelled;
        }

        public async Task<TheaterDTO> UpdateAsync(TheaterDTO entity)
        {
            var theater = await _context.Theater.FirstOrDefaultAsync(x => x.Id == entity.Id);

            theater.Name = entity.Name;
            theater.Address = entity.Address;
            theater.Image = entity.Image;
            theater.Phone = entity.Phone;
            theater.Status = entity.Status;

            foreach (var roomDto in entity.Rooms)
            {
                var room = await _context.Room
                    .FirstOrDefaultAsync(r => r.Id == roomDto.Id && r.TheaterId == entity.Id);
                if (room == null)
                {
                    room = new Room
                    {
                        Id = roomDto.Id,
                        TheaterId = theater.Id,
                        Name = roomDto.Name,
                        Status = roomDto.Status == RoomStatus.Active ? RoomStatus.Active : await  CheckShowTimeOfRoom(roomDto.Id),
                    };
                    _context.Room.Add(room);
                }
                else
                {
                    room.Name = roomDto.Name;
                    room.Status = roomDto.Status == RoomStatus.Active ? RoomStatus.Active : await CheckShowTimeOfRoom(roomDto.Id);
                }

                if(roomDto.RowNameNew.Any())
                {
                    var existingSeats = await _context.Seat
                        .Where(s => s.RoomId == room.Id)
                        .ToListAsync();

                    var newSeatDtos = roomDto.RowNameNew
                        .SelectMany(row => row.RowSeatsNew)
                        .ToList();

                    var seatsToDelete = existingSeats
                        .Where(es => !newSeatDtos.Any(ns => ns.RowName == es.RowName && ns.ColIndex == es.ColIndex))
                        .ToList();

                    _context.Seat.RemoveRange(seatsToDelete);
                }

                foreach (var rowName in roomDto.RowNameNew)
                    {
                        foreach (var seatDto in rowName.RowSeatsNew)
                        {
                            var seat = await _context.Seat.FirstOrDefaultAsync(s =>
                            s.RoomId == room.Id &&
                            s.ColIndex == seatDto.ColIndex &&
                            s.RowName == seatDto.RowName);

                            var seats = await _context.Seat.ToListAsync();

                            if (seat == null)
                            {
                                seat = new Seat
                                {
                                    RoomId = room.Id,
                                    RowName = seatDto.RowName,
                                    ColIndex = seatDto.ColIndex,
                                    IsSeat = seatDto.IsSeat,
                                    SeatTypeId = seatDto.SeatTypeId,
                                };
                                _context.Seat.Add(seat);
                            }
                            else
                            {
                                seat.IsSeat = seatDto.IsSeat;
                                seat.SeatTypeId = seatDto.SeatTypeId;
                            }
                        }
                    }
            }

            await _context.SaveChangesAsync();

            return entity;
        }

        public async Task<TheaterDTO> CreateAsync(TheaterDTO entity)
        {
            var entityDto = _mapper.Map<Theater>(entity);

            if (entity.File != null && entity.File.Length > 0)
            {
                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(entity.File.FileName);
                var filePath = Path.Combine("wwwroot/images", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await entity.File.CopyToAsync(stream);
                }
                entityDto.Image = fileName;
            }

            _context.Theater.Add(entityDto);

            await _context.SaveChangesAsync();

            var resultDto = _mapper.Map<TheaterDTO>(entityDto);

            return resultDto;
        }

        public async Task<List<TheaterRoomDTO>> GetTheaterRoomListAsync()
        {
            var theaters = await _context.Theater.Where(x => x.Status).ToListAsync();

            var theaterRoomDTOs = new List<TheaterRoomDTO>();

            foreach (var theater in theaters)
            {
                var rooms = await _context.Room.Where(x => x.TheaterId == theater.Id && x.Status == RoomStatus.Active).ToListAsync();

                var roomDTOs = new List<RoomDTO>();
                foreach (var room in rooms)
                {
                    var showTimeRooms = await _context.ShowTimeRoom.Include(x => x.ShowTime).Where(x => x.RoomId == room.Id && x.ShowTime.StartTime >= DateTime.Now.Date).ToListAsync();

                    var showTimeRoomDTOs = new List<ShowTimeRoomDTO>();
                    foreach(var showTimeRoom in showTimeRooms)
                    {
                        showTimeRoomDTOs.Add(new ShowTimeRoomDTO
                        {
                           StartTime = showTimeRoom.ShowTime.StartTime,
                           EndTime = showTimeRoom.ShowTime.EndTime,
                           ProjectionForm = showTimeRoom.ShowTime.ProjectionForm,
                        });
                    }

                    roomDTOs.Add(new RoomDTO
                    {
                        Id = room.Id,
                        Name = room.Name,
                        ShowTimeRooms = showTimeRoomDTOs,
                    });
                }

                theaterRoomDTOs.Add(new TheaterRoomDTO
                {
                    TheaterId = theater.Id,
                    TheaterName = theater.Name,
                    Rooms = roomDTOs,
                });
            }

            return theaterRoomDTOs;
        }
    }
}
