import { BOOKING, LIST_OF_SEAT_THE_USER_IS_CURRENTLY_SELECTING, SEATED, SEAT_BEING_SELECTED, SEAT_DIS_CONNECTION, SEAT_DIS_CONNECTION_NULL, SEAT_HAS_BEEN_CHOSEN, SET_COMBO, SET_MOVIE_DETAIL, SET_MOVIE_LIST, SET_SEAT, SET_TICKET_TYPE, TICKET_BOOKING_SUCCESSFUL, UPDATE_SEATED } from "../Actions/Type/CinemasType";

const stateDefault = {
    movieList: [],
    movieDetail: {},
    listSeatVailable: [],
    danhSachGheDangDat: [],
    ticketType: [],
    seat: [],
    combo: [],
    listSeated: [],
    seatYour: [],
    listOfSeatTheUserIsCurrentlySelecting: [],
    seatHasBeenChosen: '',
    listSeatDisconnection: [],
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

        case SEAT_BEING_SELECTED: {
            // let updateSeatBeingSelectedList
            // if (!action.here) {
            //     updateSeatBeingSelectedList = []
            // }
            // if (action.here) {
            //     updateSeatBeingSelectedList = [...state.seatYour]

            //     let index = updateSeatBeingSelectedList.findIndex(x => x === action.seatId);
            //     console.log("SEAT_BEING_SELECTED", index);
            //     if (index !== -1) {
            //         updateSeatBeingSelectedList.splice(index, 1);
            //     }
            //     else {
            //         updateSeatBeingSelectedList.push(action.seatId);
            //     }
            // }

            const updatedSeatYour = action.here
                ? state.seatYour.includes(action.seatId)
                    ? state.seatYour.filter(id => id !== action.seatId)
                    : [...state.seatYour, action.seatId]
                : [];

            return { ...state, seatYour: updatedSeatYour };
        }

        case SEAT_HAS_BEEN_CHOSEN: {
            return { ...state, seatHasBeenChosen: action.seatHasBeenChosen };
        }

        case LIST_OF_SEAT_THE_USER_IS_CURRENTLY_SELECTING: {
            const seatHasBeenChosen = action.seatHasBeenChosen;
            const seatIds = action.seatIds

            // Update the list of seats that the user has selected
            let updatedListOfSeatTheUserIsCurrentlySelecting = state.listOfSeatTheUserIsCurrentlySelecting.slice();

            // Handle seat selection
            if (seatIds.length > 0) {
                updatedListOfSeatTheUserIsCurrentlySelecting = [
                    ...new Set([
                        ...updatedListOfSeatTheUserIsCurrentlySelecting,
                        ...seatIds,
                    ])
                ];
            }

            // Handle seat deselection
            if (seatHasBeenChosen) {
                updatedListOfSeatTheUserIsCurrentlySelecting = updatedListOfSeatTheUserIsCurrentlySelecting.filter(id => id !== seatHasBeenChosen);
            }

            // Update the user's own seat list
            const updatedSeatYour = seatHasBeenChosen
                ? state.seatYour.filter(id => id !== seatHasBeenChosen)
                : [...state.seatYour, ...seatIds];

            // let updatedSeatBeingSelectedList = [...state.seatYour];

            // if (seatHasBeenChosen) {
            //     let index = updatedSeatBeingSelectedList.findIndex(x => x === seatHasBeenChosen);

            //     if (index !== -1) {
            //         updatedSeatBeingSelectedList.splice(index, 1);
            //     }
            // }

            console.log("state.listOfSeatTheUserIsCurrentlySelecting",state.listOfSeatTheUserIsCurrentlySelecting);
            console.log("action.seatIds", action.seatIds);

            // const updatedList = [
            //     ...new Set([
            //         ...state.listOfSeatTheUserIsCurrentlySelecting,
            //         ...action.seatIds,
            //     ]),
            // ];
            // const filteredList = updatedList.filter(id => id !== seatHasBeenChosen );

            //1, 2, 3 + 4
            // const updatedListOfSeatTheUserIsCurrentlySelecting = [...new Set([...state.listOfSeatTheUserIsCurrentlySelecting, ...seatIds])];
            // //1,2,3,4 tìm 4 có trong đó không
            // const filteredListOfSeatTheUserIsCurrentlySelecting = updatedListOfSeatTheUserIsCurrentlySelecting.filter(seatId => seatIds.includes(seatId));

            return { ...state,
                listOfSeatTheUserIsCurrentlySelecting: updatedListOfSeatTheUserIsCurrentlySelecting,
                seatHasBeenChosen: seatHasBeenChosen, 
                seatYour: updatedSeatYour
            }
        }

        case SEATED: {
            state.listSeated = [...new Set([...state.listSeated, ...action.seatIds])]
            return { ...state }
        }

        case TICKET_BOOKING_SUCCESSFUL: {
            return { ...state, listSeatVailable: [] };
        }

        case SEAT_DIS_CONNECTION: {
            const updatedList = state.listOfSeatTheUserIsCurrentlySelecting.filter(
                id => !action.seatIds.includes(id)
            );
            return {
                ...state,
                listSeatDisconnection: action.seatIds,
                listOfSeatTheUserIsCurrentlySelecting: updatedList,
            };
        }

        case SEAT_DIS_CONNECTION_NULL: {
            return { ...state, listSeatDisconnection: [] };
        }

        default: return { ...state };
    }
}