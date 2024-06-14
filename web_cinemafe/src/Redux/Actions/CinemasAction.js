import Swal from "sweetalert2";
import { SeatStatus } from "../../Enum/SeatStatus";
import { InfoTicketBooking } from "../../Models/InfoTicketBooking";
import { cinemasService } from "../../Services/CinemasService";
import { connection } from "../../connectionSignalR";
import { REMOVE_SEAT_BEING_SELECTED, SEAT_BEING_SELECTED, SET_COMBO, SET_LIST_MOVIE_BY_THEATER_ID, SET_LIST_MOVIE_BY_THEATER_ID_BOOK_QUICK_TICKET, SET_LIST_SHOWTIME_BY_MOVIEID, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_THEATER_DETAIL, SET_THEATER_LIST, SET_TICKET_TYPE, TOTAL_CHOOSES_SEAT_TYPE } from "./Type/CinemasType";
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

export const SeatBeingSelected = (infoSeat, showTimeId, roomId) => {
    return async (dispatch, getState) => {
        try {
            await dispatch({
                type: SEAT_BEING_SELECTED,
                infoSeat
            });

            const { seatYour } = getState().CinemasReducer;

            if (!seatYour || seatYour.length === 0) {
                return;
            }

            let infoTicketBooking = new InfoTicketBooking()
            infoTicketBooking.infoSeats = seatYour
            infoTicketBooking.showTimeId = showTimeId
            infoTicketBooking.roomId = roomId
            await connection.invoke("SeatBeingSelected", infoTicketBooking)

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

        let infoTicketBooking = new InfoTicketBooking();
        infoTicketBooking.infoSeats = seatYour;
        infoTicketBooking.showTimeId = showTimeId;
        infoTicketBooking.roomId = roomId;
        if (connection.state === 'Connected') {
            await connection.invoke("SeatBeingSelected", infoTicketBooking);
        } 
    }
}

const findSeatByRowAndCol = (rowName, colIndex, seats) => {
    for (let row of seats.rowName) {
        for (let seat of row.rowSeats) {
            if (row.rowName === rowName && seat.colIndex === colIndex && seat.isSeat !== false) {
                return seat.name;
            }
        }
    }

    return null;
};

export const TicketBooking = (invoiceDTO) => {
    return async (dispatch, getState) => {
        try {
            const handleInforTicket = async (seatInfos, seatStatus) => {
                if (seatStatus === SeatStatus.Sold) {
                    const { seat } = getState().CinemasReducer;
                    const seatNames = seatInfos.map(seatInfo => {
                        return findSeatByRowAndCol(seatInfo.rowName, seatInfo.colIndex, seat)
                    }).join(", ");

                    dispatch({
                        type: REMOVE_SEAT_BEING_SELECTED,
                        seatInfos, seatStatus
                    });

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
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.reload();
                        }
                    });
                }
            };

            await connection.on("InforTicket", handleInforTicket);
            await connection.invoke("CheckTheSeatBeforeBooking", invoiceDTO).then((result) => {
                if(result) {
                    history.push("/");
                    window.location.reload();
                    console.log(result);
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
            console.log("TheaterListAction: ", error);
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
            console.log("TheaterAction: ", error);
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
            console.log("ShowTimeByTheaterIdAction: ", error);
        }
    }
}

export const ListMovieByTheaterIdAction = (id) => {
    return async (dispatch) => {
        try {
            const result = await cinemasService.GetListMovieByTheaterId(id);

            dispatch({
                type: SET_LIST_MOVIE_BY_THEATER_ID_BOOK_QUICK_TICKET,
                listMovieByTheaterIdBookQuickTicket: result.data,
            })
            
        } catch (error) {
            console.log("ListMovieByTheaterIdAction: ", error);
        }
    }
}

export const ListShowTimeByMovieIdAction = (movieId, date, projetionForm) => {
    return async (dispatch) => {
        try {
            const result = await cinemasService.GetListShowTimeByMovieId(movieId, date, projetionForm);

            dispatch({
                type: SET_LIST_SHOWTIME_BY_MOVIEID,
                listShowTimeByMovieId: result.data,
            })

        } catch (error) {
            console.log("ListShowTimeByMovieIdAction: ", error);
        }
    }
}