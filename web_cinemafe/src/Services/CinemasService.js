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

    GetTheaterList = () => {
        return this.get(`api/Cinemas/GetTheaterList`)
    }

    GetTheaterId = (id) => {
        return this.get(`api/Cinemas/GetTheater/${id}`)
    }

    GetShowTimeByTheaterId = (id) => {
        return this.get(`api/Cinemas/GetShowTimeByTheaterId${id}`)
    }

    GetListMovieByTheaterId = (id) => {
        return this.get(`api/Cinemas/GetMovieTheaterId${id}`)
    }

    GetListShowTimeByMovieId = (movieId, date, projetionForm) => {
        return this.get(`api/Cinemas/GetShowTimeByMovieId/${movieId}/${date}/${projetionForm}`)
    }

    GetInvoice = (code) => {
        return this.get(`api/Cinemas/GetInvoice/${code}`)
    }

    GetAgeRestrictionList = () => {
        return this.get(`api/Cinemas/GetAgeRestrictionList`)
    }

    UpdateAgeRestriction = (ageRestrictionDTO) => {
        return this.post(`api/Cinemas/UpdateAgeRestriction`, ageRestrictionDTO)
    }

    CreateAgeRestriction = (ageRestrictionDTO) => {
        return this.post(`api/Cinemas/CreateAgeRestriction`, ageRestrictionDTO)
    }

    SearchByName = (name) => {
        return this.get(`api/Cinemas/SearchByName${name}`)
    }
}

export const cinemasService = new CinemasService()