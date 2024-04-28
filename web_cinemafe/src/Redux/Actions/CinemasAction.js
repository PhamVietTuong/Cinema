import { Ticket } from "../../Models/Ticket";
import { TicketBookingInformation } from "../../Models/TicketBookingInformation";
import { cinemasService } from "../../Services/CinemasService";
import { SET_COMBO, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_SHOWTIME_DETAIL, SET_TICKET_TYPE, TICKET_BOOKING_SUCCESSFUL } from "./Type/CinemasType";
import { connection } from "../..";

export const MovieListAction = () => {
    return async (dispatch) => {
        try {
            const result = await cinemasService.GetMovieList();
            dispatch({
                type: SET_MOVIE_LIST,
                movieList: result.data,
            })
        } catch (error) {
            console.log("listMovieAction: ", error);
        }
    }
}

export const MovieDetailAction = (id) => {
    return async (dispatch) => {
        try {
            const result = await cinemasService.GetMovieDetail(id);

            dispatch({
                type: SET_MOVIE_DETAIL,
                movieDetail: result.data,
            });
        } catch (errors) {
            console.log("MovieDetailAction", errors);
        }
    }
}

export const TicketTypeAction = (showTimeId) => {
    return async (dispatch) => {
        try {
            const ticketType = await cinemasService.GetTicketTypeByShowTimeId(showTimeId);

            dispatch({
                type: SET_TICKET_TYPE,
                ticketType: ticketType.data,
            });
        } catch (errors) {
            console.log("TicketTypeAction", errors);
        }
    }
}

export const SeatlAction = (showTimeId) => {
    return async (dispatch) => {
        try {
            const seat = await cinemasService.GetSeatByShowTimeId(showTimeId);

            dispatch({
                type: SET_SEAT,
                seat: seat.data,
            });
        } catch (errors) {
            console.log("SeatlAction", errors);
        }
    }
}

export const ComboAction = () => {
    return async (dispatch) => {
        try {
            const combo = await cinemasService.GetCombo();

            dispatch({
                type: SET_COMBO,
                combo: combo.data,
            });
        } catch (errors) {
            console.log("ComboAction", errors);
        }
    }
}

export const TicketBooking = (ticket = new Ticket()) => {
    return async (dispatch) => {
        try {
            const ticketBooking = await cinemasService.PostTicket(ticket)

            if (ticketBooking.status === 200) {

                await dispatch({
                    type: TICKET_BOOKING_SUCCESSFUL,
                });

                await connection.invoke("TicketBookingSuccess", ticket)
            }
        } catch (error) {
            
        }
    }
}