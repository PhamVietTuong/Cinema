import { Axios } from "axios";
import { baseService } from "./BaseService";
import { DOMAIN, TOKEN } from "../Ustil/Settings/Config";

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

    GetTheaterListAdmin = () => {
        return this.get(`api/Cinemas/GetTheaterListAdmin`)
    }

    UpdateTheater = (theaterDTO) => {
        return this.post(`api/Cinemas/UpdateTheater`, theaterDTO)
    }

    CreateTheater = (theaterDTO) => {
        return cinemasService.postImage(`api/Cinemas/CreateTheater`, theaterDTO);
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

    GetTicketTypeList = () => {
        return this.get(`api/Cinemas/GetTicketTypeList`)
    }

    UpdateTicketType = (ticketTypeDTO) => {
        return this.post(`api/Cinemas/UpdateTicketType`, ticketTypeDTO)
    }

    CreateTicketType = (ticketTypeDTO) => {
        return this.post(`api/Cinemas/CreateTicketType`, ticketTypeDTO)
    }

    GetMovieTypeList = () => {
        return this.get(`api/Cinemas/GetMovieTypeList`)
    }

    UpdateMovieType = (movieTypeDTO) => {
        return this.post(`api/Cinemas/UpdateMovieType`, movieTypeDTO)
    }

    CreateMovieType = (movieTypeDTO) => {
        return this.post(`api/Cinemas/CreateMovieType`, movieTypeDTO)
    }

    GetSeatTypeList = () => {
        return this.get(`api/Cinemas/GetSeatTypeList`)
    }

    UpdateSeatType = (seatTypeDTO) => {
        return this.post(`api/Cinemas/UpdateSeatType`, seatTypeDTO)
    }

    CreateSeatType = (seatTypeDTO) => {
        return this.post(`api/Cinemas/CreateSeatType`, seatTypeDTO)
    }

    GetUserTypeList = () => {
        return this.get(`api/Cinemas/GetUserTypeList`)
    }

    UpdateUserType = (userTypeDTO) => {
        return this.post(`api/Cinemas/UpdateUserType`, userTypeDTO)
    }

    CreateUserType = (userTypeDTO) => {
        return this.post(`api/Cinemas/CreateUserType`, userTypeDTO)
    }

    SearchByName = (name) => {
        return this.get(`api/Cinemas/SearchByName${name}`)
    }

    GetInvoiceList = (userId) => {
        return this.get(`api/Cinemas/GetInvoiceList/${userId}`)
    }
}

export const cinemasService = new CinemasService()