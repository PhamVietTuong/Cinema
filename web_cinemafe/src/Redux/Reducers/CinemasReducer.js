import Swal from "sweetalert2";
import { SeatStatus } from "../../Enum/SeatStatus";
import { CHECK_FOR_EMPTY_SEAT, CLEAN, GET_WAITING_SEAT, INFO_SEARCH, LIST_OF_SEATS_SOLD, REMOVE_SEAT_BEING_SELECTED, SAVE_BOOKING_INFO, SEAT_BEING_SELECTED, SEAT_HAS_BEEN_CHOSEN, SET_COMBO, SET_DATA_STATICTICAL, SET_INFO_THEATER, SET_INVOICE_BY_CODE, SET_LIST_AGERESTRICTION, SET_LIST_INVOICE_BY_USER, SET_LIST_MOVIETYPE, SET_LIST_MOVIE_BY_THEATER_ID, SET_LIST_MOVIE_BY_THEATER_ID_BOOK_QUICK_TICKET, SET_LIST_SEATTYPE, SET_LIST_SHOWTIME_BY_MOVIEID, SET_LIST_TICKETTYPE, SET_LIST_USERTYPE, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_THEATER_DETAIL, SET_THEATER_LIST, SET_TICKET_TYPE, TOTAL_CHOOSES_SEAT_TYPE, UPDATE_SEAT } from "../Actions/Type/CinemasType";

const stateDefault = {
    movieList: [],
    movieDetail: {},
    listSeatVailable: [],
    danhSachGheDangDat: [],
    ticketType: [],
    seat: [],
    combo: [],
    listOfSeatSold: [],
    seatYour: [],
    listOfSeatTheUserIsCurrentlySelecting: [],
    seatHasBeenChosen: '',
    listSeatDisconnection: [],
    seatState: 0,
    listWattingSeat: [],
    updateSeat: [],
    seatTypeMapping: {},
    totalSeatType: {},
    checkBooking: false,
    seatYourName: '',
    theaterList: [],
    theaterDetail: {},
    listMovieByTheaterId: [],
    listMovieByTheaterIdBookQuickTicket: [],
    listShowTimeByMovieId: [],
    ageRestrictionList: [],
    ticketTypeList: [],
    movieTypeList: [],
    seatTypeList: [],
    userTypeList: [],
    movieInfoBooking: {},
    invoiceDTO: {},
    code: '',
    resultInfoSearch: [],
    infoTheater: {},
    listInvoiceByUser: [],
    invoiceByCode: {},
    dataRevenue: []
}

const createSeatTypeMapping = (seatData) => {
    let mapping = {};

    seatData.rowName.forEach(row => {
        row.rowSeats.forEach(seat => {
            if (seat.seatTypeId && seat.isSeat !== false) {
                mapping[`${row.rowName}-${seat.colIndex}`] = seat.seatTypeId;
            }
        });
    });

    return mapping;
};

const checkIfSeatsAreEnough = (seatYour, seatTypeMapping, totalSeatType) => {
    let seatCount = {};

    seatYour.forEach(seatInfo => {
        const seatTypeId = seatTypeMapping[`${seatInfo.rowName}-${seatInfo.colIndex}`];
        if (seatTypeId) {
            if (!seatCount[seatTypeId]) {
                seatCount[seatTypeId] = 0;
            }
            seatCount[seatTypeId]++;
        }
    });

    for (let seatTypeId in totalSeatType) {
        if ((seatCount[seatTypeId] || 0) < totalSeatType[seatTypeId]) {
            return false;
        }
    }

    return true;
};

export const CinemasReducer = (state = stateDefault, action) => {
    switch (action.type) {
        case SET_MOVIE_LIST: {
            return { ...state, movieList: action.movieList };
        }

        case SET_MOVIE_DETAIL: {
            return { ...state, movieDetail: action.movieDetail };
        }

        case SET_TICKET_TYPE: {
            return { ...state, ticketType: action.ticketType };
        }

        case SET_SEAT: {
            const seatTypeMapping = createSeatTypeMapping(action.seat);
            return { ...state, seat: action.seat, seatTypeMapping };
        }

        case SET_COMBO: {
            return { ...state, combo: action.combo };
        }

        case SEAT_BEING_SELECTED: {
            const { infoSeat } = action;
            const { seatTypeMapping, totalSeatType } = state;
            const updatedSeatYour = state.seatYour.find(seat => seat.rowName === infoSeat.rowName && seat.colIndex === infoSeat.colIndex)
                ? state.seatYour.filter(seat => !(seat.rowName === infoSeat.rowName && seat.colIndex === infoSeat.colIndex))
                : [...state.seatYour, infoSeat]

            const seatTypeId = seatTypeMapping[`${infoSeat.rowName}-${infoSeat.colIndex}`];
            const currentSelectedCount = updatedSeatYour.filter(seat => seatTypeMapping[`${seat.rowName}-${seat.colIndex}`] === seatTypeId).length;

            if ((totalSeatType[seatTypeId] || 0) === 0) {
                Swal.fire({
                    title: `LƯU Ý !`,
                    text: "Bạn cần chọn loại ghế!",
                    padding: "24px",
                    width: "400px",
                    customClass: {
                        confirmButton: 'custom-ok-button'
                    },
                    showCancelButton: false,
                });
                return state;
            }

            if ((totalSeatType[seatTypeId] || 0) - currentSelectedCount <= -1) {
                Swal.fire({
                    title: `LƯU Ý !`,
                    text: "Bạn đã mua đủ ghế loại này!",
                    padding: "24px",
                    width: "400px",
                    customClass: {
                        confirmButton: 'custom-ok-button'
                    },
                    confirmButtonText: "Oki",
                    showCancelButton: false,
                });
                return state;
            }

            const updateCheckBooking = checkIfSeatsAreEnough(updatedSeatYour, seatTypeMapping, totalSeatType);

            return { ...state, seatYour: updatedSeatYour, checkBooking: updateCheckBooking };
        }

        case SEAT_HAS_BEEN_CHOSEN: {
            return { ...state, seatHasBeenChosen: action.seatHasBeenChosen };
        }

        case UPDATE_SEAT: {
            const { seatInfos, seatStatus } = action;
            let updatedSeats = [...state.updateSeat];

            if (seatStatus === SeatStatus.Waiting || seatStatus === SeatStatus.Sold) {
                updatedSeats = [...new Set([...updatedSeats, ...seatInfos])];
            } else if (seatStatus === 1) {
                updatedSeats = updatedSeats.filter(info => !seatInfos.some(seat => seat.rowName === info.rowName && seat.colIndex === info.colIndex));
            }

            return {
                ...state,
                updateSeat: updatedSeats
            }
        }

        case GET_WAITING_SEAT: {
            return {
                ...state,
                updateSeat: [...new Set([...state.updateSeat, ...action.seatInfos])],
            }
        }

        case LIST_OF_SEATS_SOLD: {
            return {
                ...state,
                listOfSeatSold: [...new Set([...state.listOfSeatSold, ...action.seatInfos])]
            }
        }

        case CHECK_FOR_EMPTY_SEAT: {
            const { seatInfos, seatStatus } = action;
            const { seatTypeMapping, totalSeatType } = state;

            let updatedSeatsYour = [...state.seatYour];

            const seatsToCheck = Array.isArray(seatInfos) ? seatInfos : [seatInfos];

            if (seatStatus === SeatStatus.Waiting || seatStatus === SeatStatus.Sold) {
                updatedSeatsYour = updatedSeatsYour.filter(info => !seatsToCheck.some(seat => seat.rowName === info.rowName && seat.colIndex === info.colIndex))
            }

            const updateCheckBooking = checkIfSeatsAreEnough(updatedSeatsYour, seatTypeMapping, totalSeatType);

            return { ...state, seatYour: updatedSeatsYour, checkBooking: updateCheckBooking };
        }

        case REMOVE_SEAT_BEING_SELECTED: {
            const { seatInfos, seatStatus } = action;
            let updatedSeatsYour = [...state.seatYour];

            if (seatStatus === SeatStatus.Waiting || seatStatus === SeatStatus.Sold) {
                updatedSeatsYour = updatedSeatsYour.filter(info => !seatInfos.some(seat => seat.rowName === info.rowName && seat.colIndex === info.colIndex))
            }

            return { ...state, seatYour: updatedSeatsYour };
        }

        case CLEAN: {
            return { ...state, listOfSeatSold: [], updateSeat: [], listWattingSeat: [], seatYour: [] };
        }

        case TOTAL_CHOOSES_SEAT_TYPE: {
            return { ...state, totalSeatType: action.totalSeatType, seatYour: [] };
        }

        case SET_THEATER_LIST: {
            return { ...state, theaterList: action.theaterList };
        }

        case SET_THEATER_DETAIL: {
            return { ...state, theaterDetail: action.theaterDetail };
        }

        case SET_LIST_MOVIE_BY_THEATER_ID: {
            return { ...state, listMovieByTheaterId: action.listMovieByTheaterId };
        }

        case SET_LIST_MOVIE_BY_THEATER_ID_BOOK_QUICK_TICKET: {
            return { ...state, listMovieByTheaterIdBookQuickTicket: action.listMovieByTheaterIdBookQuickTicket };
        }

        case SET_LIST_SHOWTIME_BY_MOVIEID: {
            return { ...state, listShowTimeByMovieId: action.listShowTimeByMovieId };
        }

        case SET_LIST_AGERESTRICTION: {
            return { ...state, ageRestrictionList: action.ageRestrictionList };
        }

        case SET_LIST_TICKETTYPE: {
            return { ...state, ticketTypeList: action.ticketTypeList };
        }

        case SET_LIST_MOVIETYPE: {
            return { ...state, movieTypeList: action.movieTypeList };
        }

        case SET_LIST_SEATTYPE: {
            return { ...state, seatTypeList: action.seatTypeList };
        }

        case SET_LIST_USERTYPE: {
            return { ...state, userTypeList: action.userTypeList };
        }
        
        case SAVE_BOOKING_INFO:
            return {
                ...state,
                invoiceDTO: action.invoiceDTO,
                movieInfoBooking: action.movieInfoBooking
            };

        case INFO_SEARCH:
            return {
                ...state,
                resultInfoSearch: action.resultInfoSearch,
            };
        
        case SET_INFO_THEATER:
            return {
                ...state,
                infoTheater: action.infoTheater,
            };

        case SET_LIST_INVOICE_BY_USER: {
                return { ...state, listInvoiceByUser: action.listInvoiceByUser };
        }

        case SET_INVOICE_BY_CODE: {
            return { ...state, invoiceByCode: action.invoiceByCode };
        }

        case SET_DATA_STATICTICAL: {
            return { ...state, dataRevenue: action.dataRevenue };
        }

        default: return { ...state };
    }
}