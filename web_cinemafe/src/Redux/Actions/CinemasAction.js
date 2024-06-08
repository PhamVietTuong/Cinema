import Swal from "sweetalert2";
import { SeatStatus } from "../../Enum/SeatStatus";
import { TicketBookingSuccess } from "../../Models/TicketBookingSuccess";
import { cinemasService } from "../../Services/CinemasService";
import { connection } from "../../connectionSignalR";
import { REMOVE_SEAT_BEING_SELECTED, SEAT_BEING_SELECTED, SEAT_HAS_BEEN_CHOSEN, SET_COMBO, SET_LIST_MOVIE_BY_THEATER_ID, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_THEATER_DETAIL, SET_THEATER_LIST, SET_TICKET_TYPE, TICKET_BOOKING_SUCCESSFUL, TOTAL_CHOOSES_SEAT_TYPE } from "./Type/CinemasType";
import { history } from "../../Routers";

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
            const result = await cinemasService.PostMovieDetail(movieDetailDTO);

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
            const ticketType = await cinemasService.PostTicketTypeByShowTimeAndRoomId(ticketTypeByShowTimeDTO);
            
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
            const seat = await cinemasService.PostSeatByShowTimeAndRoomId(seatByShowTimeAndRoomDTO);

            dispatch({
                type: SET_SEAT,
                seat: seat.data,
            });
        } catch (errors) {
            console.log("SeatAction", errors);
        }
    }
}

export const ComboAction = (theaterId) => {
    return async (dispatch) => {
        try {
            const combo = await cinemasService.GetComboByTheaterId(theaterId);

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
                seatId
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

export const updateTotalSeatTypeAndProceed = (totalSeatType, showTimeId, roomId) => {
    return async (dispatch, getState) => {
        dispatch({
            type: TOTAL_CHOOSES_SEAT_TYPE,
            totalSeatType
        });

        const { seatYour } = getState().CinemasReducer;

        let ticketBookingSuccess = new TicketBookingSuccess();
        ticketBookingSuccess.seatIds = seatYour;
        ticketBookingSuccess.showTimeId = showTimeId;
        ticketBookingSuccess.roomId = roomId;
        if (connection.state === 'Connected') {
            await connection.invoke("SeatBeingSelected", ticketBookingSuccess);
        } 
    }
}

export const TicketBooking = (invoiceDTO) => {
    return async (dispatch) => {
        try {
            const handleInforTicket = async (tickets, seatStatus) => {
                if (seatStatus === SeatStatus.Sold) {
                    const seatNames = tickets.map(x => x.seat.name).join(", ");
                    let seatIds = tickets.map(x => x.seat.id);
                    Swal.fire({
                        title: `LƯU Ý !`,
                        text: "Đã có người mua ghế: " + seatNames,
                        padding: "24px",
                        width: "400px",
                        customClass: {
                            confirmButton: 'custom-ok-button'
                        },
                        showCancelButton: false,
                        confirmButtonText: "Thử lại",
                    });
                    dispatch({
                        type: REMOVE_SEAT_BEING_SELECTED,
                        seatIds, seatStatus
                    });
                }
                // else {
                //     const ticketBooking = await cinemasService.PostTicket(invoiceDTO);

                //     if (ticketBooking.status === 200) {
                //         await connection.invoke("TicketBookingSuccess", invoiceDTO);
                //         window.location.reload();
                //         alert("Đặt vé thành công");
                //     }
                // }
            };
            await connection.on("InforTicket", handleInforTicket);
            await connection.invoke("CheckTheSeatBeforeBooking", invoiceDTO).then((result) => {
                if(result) {
                    history.push("/");
                    window.location.reload();
                }
            })
        } catch (error) {
            console.log("TicketBooking", error);
        }
    }
}

export const TheaterListAction = () => {
    return async (dispatch) => {
        try {
            const result = await cinemasService.GetTheaterList();
            dispatch({
                type: SET_THEATER_LIST,
                theaterList: result.data,
            })
        } catch (error) {
            console.log("listMovieAction: ", error);
        }
    }
}

export const TheaterAction = (id) => {
    return async (dispatch) => {
        try {
            const result = await cinemasService.GetTheaterId(id);
            dispatch({
                type: SET_THEATER_DETAIL,
                theaterDetail: result.data,
            })
        } catch (error) {
            console.log("listMovieAction: ", error);
        }
    }
}

export const ShowTimeByTheaterIdAction = (id) => {
    return async (dispatch) => {
        try {
            const result = await cinemasService.GetShowTimeByTheaterId(id);
            dispatch({
                type: SET_LIST_MOVIE_BY_THEATER_ID,
                listMovieByTheaterId: result.data,
            })
        } catch (error) {
            console.log("listMovieAction: ", error);
        }
    }
}