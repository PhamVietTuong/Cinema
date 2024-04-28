import { Ticket } from "../Models/Ticket";
import { TicketBookingInformation } from "../Models/TicketBookingInformation";
import { baseService } from "./BaseService";

export class CinemasService extends baseService {
    GetMovieList = () => {
        return this.get(`api/Cinemas/GetMovieList`)
    }

    GetMovieDetail = (id) => {
        return this.get(`api/Cinemas/MovieDetail/${id}`)
    }

    GetTicketTypeByShowTimeId = (showTimeId) => {
        return this.get(`api/Cinemas/TicketTypeByShowTime/${showTimeId}`);
    }

    GetSeatByShowTimeId = (showTimeId) => {
        return this.get(`api/Cinemas/SeatByShowTime/${showTimeId}`);
    }

    GetCombo = () => {
        return this.get(`api/Cinemas/Combo`);
    }

    GetInformationAboutBoxOffice = (showTimeId) => {
        return this.get(`api/Cinemas/GetInformationAboutBoxOffice?showTimeId=${showTimeId}`);
    }

    PostTicket = (ticket = new Ticket()) => {
        return this.post(`api/Cinemas/Ticket`, ticket);
    }

    TicketBooking = (ticketBookingInformation = new TicketBookingInformation()) => {
    }
}

export const cinemasService = new CinemasService()