import { baseService } from "./BaseService";

export class CinemasService extends baseService {
    GetMovieList = () => {
        return this.get(`api/Cinemas/GetMovieList`)
    }

    GetMovieDetail = (id) => {
        return this.get(`api/Cinemas/MovieDetail/${id}`)
    }

    GetTicketTypeByShowTimeAndRoomId = (ticketTypeByShowTimeDTO) => {
        return this.post(`api/Cinemas/TicketTypeByShowTimeAndRoomId`, ticketTypeByShowTimeDTO);
    }

    GetSeatByShowTimeAndRoomId = (seatByShowTimeAndRoomDTO) => {
        return this.post(`api/Cinemas/SeatByShowTimeAndRoomId`, seatByShowTimeAndRoomDTO);
    }

    GetCombo = () => {
        return this.get(`api/Cinemas/Combo`);
    }

    GetInformationAboutBoxOffice = (showTimeId) => {
        return this.get(`api/Cinemas/GetInformationAboutBoxOffice?showTimeId=${showTimeId}`);
    }

    PostTicket = (ticketBookingSuccess) => {
        return this.post(`api/Cinemas/Ticket`, ticketBookingSuccess);
    }
}

export const cinemasService = new CinemasService()