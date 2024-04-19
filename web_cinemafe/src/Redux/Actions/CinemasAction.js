import { TicketBookingInformation } from "../../Models/TicketBookingInformation";
import { cinemasService } from "../../Services/CinemasService";
import { SET_COMBO, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_SHOWTIME_DETAIL, SET_TICKET_TYPE } from "./Type/CinemasType";

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

export const TicketBooking = (ticketBookingInformation = new TicketBookingInformation()) => {
    return async (dispatch, getState) => {
        try {
            const result = await cinemasService.TicketBooking

        } catch (error) {
            console.log("TicketBooking: ", error);
        }
    };
};