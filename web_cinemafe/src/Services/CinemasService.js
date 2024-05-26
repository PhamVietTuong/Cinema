import { baseService } from "./BaseService";

export class CinemasService extends baseService {
    GetMovieList = () => {
        return this.get(`api/Cinemas/GetMovieList`)
    }

    PostMovieDetail = (movieDetailDTO) => {
        return this.post(`api/Cinemas/MovieDetail`, movieDetailDTO)
    }

    PostTicketTypeByShowTimeAndRoomId = (ticketTypeByShowTimeDTO) => {
        return this.post(`api/Cinemas/TicketTypeByShowTimeAndRoomId`, ticketTypeByShowTimeDTO);
    }

    PostSeatByShowTimeAndRoomId = (seatByShowTimeAndRoomDTO) => {
        return this.post(`api/Cinemas/SeatByShowTimeAndRoomId`, seatByShowTimeAndRoomDTO);
    }

    GetComboByTheaterId = (theaterId) => {
        return this.get(`api/Cinemas/ComboByTheaterId/${theaterId}`);
    }

    GetInformationAboutBoxOffice = (showTimeId) => {
        return this.get(`api/Cinemas/GetInformationAboutBoxOffice?showTimeId=${showTimeId}`);
    }

    PostTicket = (ticketBookingSuccess) => {
        return this.post(`api/Cinemas/Ticket`, ticketBookingSuccess);
    }
}

export const cinemasService = new CinemasService()