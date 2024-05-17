import { TicketBookingSuccess } from "../../Models/TicketBookingSuccess";
import { cinemasService } from "../../Services/CinemasService";
import { connection } from "../../connectionSignalR";
import { SEAT_BEING_SELECTED, SEAT_HAS_BEEN_CHOSEN, SET_COMBO, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_TICKET_TYPE, TICKET_BOOKING_SUCCESSFUL } from "./Type/CinemasType";

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

export const TicketTypeAction = (ticketTypeByShowTimeDTO) => {
    return async (dispatch) => {
        try {
            const ticketType = await cinemasService.GetTicketTypeByShowTimeAndRoomId(ticketTypeByShowTimeDTO);

            dispatch({
                type: SET_TICKET_TYPE,
                ticketType: ticketType.data,
            });
        } catch (errors) {
            console.log("TicketTypeAction", errors);
        }
    }
}

export const SeatAction = (seatByShowTimeAndRoomDTO) => {
    return async (dispatch) => {
        try {
            const seat = await cinemasService.GetSeatByShowTimeAndRoomId(seatByShowTimeAndRoomDTO);

            dispatch({
                type: SET_SEAT,
                seat: seat.data,
            });
        } catch (errors) {
            console.log("SeatAction", errors);
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

export const SeatBeingSelected = (seatId, showTimeId) => {
    return async (dispatch, getState) => {
        try {
            await dispatch({
                type: SEAT_BEING_SELECTED,
                seatId,
                here: true
            });

            // let seatYour = getState().CinemasReducer.seatYour;
            const { seatYour } = getState().CinemasReducer;

            let ticketBookingSuccess = new TicketBookingSuccess()
            ticketBookingSuccess.seatIds = seatYour
            ticketBookingSuccess.showTimeId = showTimeId
            await connection.invoke("SeatBeingSelected", ticketBookingSuccess)

        } catch (error) {
            console.log("SeatBeingSelected", error);
        }
    }
}

export const TicketBooking = (ticket) => {
    return async (dispatch) => {
        try {
            const ticketBooking = await cinemasService.PostTicket(ticket)

            if (ticketBooking.status === 200) {

                await dispatch({
                    type: TICKET_BOOKING_SUCCESSFUL,
                });

                await connection.invoke("TicketBookingSuccess", ticket)
                window.location.reload();
                alert("Đặt vé thành công")
            }
        } catch (error) {
            
        }
    }
}