import { BOOKING, SEATED, SET_COMBO, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_TICKET_TYPE, TICKET_BOOKING_SUCCESSFUL, UPDATE_SEATED } from "../Actions/Type/CinemasType";

const stateDefault = {
    movieList: [],
    movieDetail: {},
    listSeatVailable: [],
    danhSachGheDangDat: [],
    ticketType: [],
    seat: [],
    combo: [],
    listSeated: []
}

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
            state.seat = action.seat;
            return { ...state };
        }

        case SET_COMBO: {
            state.combo = action.combo;
            return { ...state };
        }

        case SEATED: {
            state.listSeated = action.seatIds
            return {...state}
        }

        case TICKET_BOOKING_SUCCESSFUL: {
            return { ...state, listSeatVailable: [] };
        }

        default: return { ...state };
    }
}