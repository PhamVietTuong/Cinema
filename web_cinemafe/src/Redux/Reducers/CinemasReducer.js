import Swal from "sweetalert2";
import { SeatStatus } from "../../Enum/SeatStatus";
import { CHECK_FOR_EMPTY_SEAT, CLEAN, GET_WAITING_SEAT, LIST_OF_SEATS_SOLD, REMOVE_SEAT_BEING_SELECTED, SEAT_BEING_SELECTED, SEAT_HAS_BEEN_CHOSEN, SET_COMBO, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_TICKET_TYPE, TOTAL_CHOOSES_SEAT_TYPE, UPDATE_SEAT } from "../Actions/Type/CinemasType";

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
}

const createSeatTypeMapping = (seatData) => {
    let mapping = {};
    seatData.rowName.forEach(row => {
        row.rowSeats.forEach(seat => {
            if (seat.seatTypeId) {
                mapping[seat.id] = seat.seatTypeId;
            }
        });
    });
    return mapping;
};

export const CinemasReducer = (state = stateDefault, action) => {
    switch (action.type) {
        case SET_MOVIE_LIST: {
            state.movieList = action.movieList;
            return { ...state };
        }

        case SET_MOVIE_DETAIL: {
            state.movieDetail = action.movieDetail;
            return { ...state};
        }
        
        case SET_TICKET_TYPE: {
            state.ticketType = action.ticketType;
            return { ...state };
        }

        case SET_SEAT: {
            const seatTypeMapping = createSeatTypeMapping(action.seat);
            return { ...state, seat: action.seat, seatTypeMapping };
        }

        case SET_COMBO: {
            return { ...state, combo: action.combo };
        }

        case SEAT_BEING_SELECTED: {
            const { seatId } = action;
            const { seatTypeMapping, totalSeatType } = state;
            const updatedSeatYour = state.seatYour.includes(seatId)
                ? state.seatYour.filter(id => id !== seatId)
                : [...state.seatYour, seatId]

            const seatTypeId = seatTypeMapping[seatId];
            const currentSelectedCount = updatedSeatYour.filter(seat => seatTypeMapping[seat] === seatTypeId).length;

            if ((totalSeatType[seatTypeId] || 0) === 0) {
                Swal.fire({
                    title: `LƯU Ý !`,
                    text: "Bạn cần chọn loại ghế!",
                    padding: "24px",
                    width: "400px",
                    customClass: {
                        confirmButton: 'custom-ok-button'
                    }
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
                    }
                });
                return state; 
            }
            return { ...state, seatYour: updatedSeatYour };
        }

        case SEAT_HAS_BEEN_CHOSEN: {
            return { ...state, seatHasBeenChosen: action.seatHasBeenChosen };
        }

        case UPDATE_SEAT: {
            const { seatId, seatStatus } = action;
            let updatedSeats = [...state.updateSeat];

            if (seatStatus === SeatStatus.Waiting || seatStatus === SeatStatus.Sold) {
                updatedSeats = [...new Set([...updatedSeats, ...seatId])];
            } else if (seatStatus === 1) {
                updatedSeats = updatedSeats.filter(id => !seatId.includes(id));
            }

            return {
                ...state,
                updateSeat: updatedSeats
            }
        } 

        case GET_WAITING_SEAT: {
            return {
                ...state,
                updateSeat: [...new Set([...state.updateSeat, ...action.seatIds])],
            }
        }

        case LIST_OF_SEATS_SOLD: {
            state.listOfSeatSold = [...new Set([...state.listOfSeatSold, ...action.seatIds])]
            return { ...state }
        }

        case CHECK_FOR_EMPTY_SEAT: {
            const { seatId, seatStatus } = action;
            let updatedSeatsYour = [...state.seatYour];

            if (seatStatus === SeatStatus.Waiting || seatStatus === SeatStatus.Sold) {
                updatedSeatsYour = updatedSeatsYour.filter(id => !seatId.includes(id))
            }

            return { ...state, seatYour: updatedSeatsYour };
        }

        case REMOVE_SEAT_BEING_SELECTED: {
            const { seatIds, seatStatus } = action;
            let updatedSeatsYour = [...state.seatYour];

            if (seatStatus === SeatStatus.Waiting || seatStatus === SeatStatus.Sold) {
                updatedSeatsYour = updatedSeatsYour.filter(id => !seatIds.includes(id))
            }

            return { ...state, seatYour: updatedSeatsYour };
        }

        case CLEAN: {
            return { ...state, listOfSeatSold: [], updateSeat: [], listWattingSeat: [], seatYour: [] };
        }

        case TOTAL_CHOOSES_SEAT_TYPE: {
            return { ...state, totalSeatType: action.totalSeatType, seatYour: [] };
        }

        default: return { ...state };
    }
}