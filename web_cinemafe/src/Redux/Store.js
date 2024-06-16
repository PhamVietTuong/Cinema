import { applyMiddleware, combineReducers, legacy_createStore as createStore } from "redux";
import { thunk, withExtraArgument } from "redux-thunk";
import { CinemasReducer } from "./Reducers/CinemasReducer";
import { UserReducer } from "./Reducers/UserReducer";

const rootReducer = combineReducers({
    CinemasReducer,
    UserReducer
});

export const store = createStore(rootReducer, applyMiddleware(thunk));
