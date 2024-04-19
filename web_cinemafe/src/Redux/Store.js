import { applyMiddleware, combineReducers, legacy_createStore as createStore } from "redux";
import { thunk, withExtraArgument } from "redux-thunk";
import { CinemasReducer } from "./Reducers/CinemasReducer";

const rootReducer = combineReducers({
    CinemasReducer
});

export const store = createStore(rootReducer, applyMiddleware(thunk));
