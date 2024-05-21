import { SeatStatus } from "../../Enum/SeatStatus";
import { TicketBookingSuccess } from "../../Models/TicketBookingSuccess";
import { cinemasService } from "../../Services/CinemasService";
import { connection } from "../../connectionSignalR";
import { REMOVE_SEAT_BEING_SELECTED, SEAT_BEING_SELECTED, SEAT_HAS_BEEN_CHOSEN, SET_COMBO, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_TICKET_TYPE, TICKET_BOOKING_SUCCESSFUL } from "./Type/CinemasType";

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

export const MovieDetailAction = (movieDetailDTO) => {
    return async (dispatch) => {
        try {
            const result = await cinemasService.GetMovieDetail(movieDetailDTO);

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

export const SeatBeingSelected = (seatId, showTimeId, roomId) => {
    return async (dispatch, getState) => {
        try {
            await dispatch({
                type: SEAT_BEING_SELECTED,
                seatId,
                here: true
            });

            const { seatYour } = getState().CinemasReducer;

            let ticketBookingSuccess = new TicketBookingSuccess()
            ticketBookingSuccess.seatIds = seatYour
            ticketBookingSuccess.showTimeId = showTimeId
            ticketBookingSuccess.roomId = roomId
            await connection.invoke("SeatBeingSelected", ticketBookingSuccess)

        } catch (error) {
            console.log("SeatBeingSelected", error);
        }
    }
}

export const TicketBooking = (ticket) => {
    return async (dispatch) => {
        try {
            const handleInforTicket = async (tickets, seatStatus) => {
                if (seatStatus === SeatStatus.Sold) {
                    const seatNames = tickets.map(x => x.seat.name).join(", ");
                    let seatIds = tickets.map(x => x.seat.id);

                    alert("Đã có người mua: " + seatNames);

                    dispatch({
                        type: REMOVE_SEAT_BEING_SELECTED,
                        seatIds, seatStatus
                    });
                } else {
                    const ticketBooking = await cinemasService.PostTicket(ticket);

                    if (ticketBooking.status === 200) {
                        await connection.invoke("TicketBookingSuccess", ticket);
                        window.location.reload();
                        alert("Đặt vé thành công");
                    }
                }
            };

            await connection.on("InforTicket", handleInforTicket);
            await connection.invoke("CheckTheSeatBeforeBooking", ticket)
        } catch (error) {
            console.log("TicketBooking", error);
        }
    }
}