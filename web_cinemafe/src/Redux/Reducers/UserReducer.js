import { SEARCH_HISTORY, TOKEN, USER_LOGIN } from "../../Ustil/Settings/Config";
import { ADD_SEARCH_HISTORY, LOGIN_USER, LOGOUT, REGISTER_USER, REMOVE_SEARCH_HISTORY, SET_LIST_USER, SET_RESULT_SEND_CODE } from "../Actions/Type/UserType";

let user = {};
if (localStorage.getItem(USER_LOGIN) || sessionStorage.getItem(USER_LOGIN)) {
    user = JSON.parse(localStorage.getItem(USER_LOGIN) || sessionStorage.getItem(USER_LOGIN));
}

const stateDefault = {
    loginInfo: user,
    isLoggedIn: Object.keys(user).length !== 0,
    userId: user.phone,
    listUser: [],
    resultSendCode: {},
    searchHistory: JSON.parse(localStorage.getItem(SEARCH_HISTORY)) || [],
}

export const UserReducer = (state = stateDefault, action) => {
    switch (action.type) {
        case LOGIN_USER: {
            const { loginInfo, rememberMe} = action;

            if (rememberMe) {
                localStorage.setItem(USER_LOGIN, JSON.stringify(loginInfo));
                localStorage.setItem(TOKEN, loginInfo.token);
            } else {
                sessionStorage.setItem(USER_LOGIN, JSON.stringify(loginInfo));
                sessionStorage.setItem(TOKEN, loginInfo.token);
            }

            return {
                ...state,
                isLoggedIn: true,
                loginInfo: loginInfo,
                userId: loginInfo.phone
            };
        }

        case LOGOUT: {
            sessionStorage.removeItem(USER_LOGIN);
            sessionStorage.removeItem(TOKEN);
            localStorage.removeItem(USER_LOGIN);
            localStorage.removeItem(TOKEN);
            localStorage.removeItem(SEARCH_HISTORY);
            window.location.href = '/';
            return {
                ...state,
                isLoggedIn: false,
                user: null,
                userId: ""
            };
        }

        case SET_LIST_USER: {
            return { ...state, listUser: action.listUser };
        }

        case SET_RESULT_SEND_CODE: {
            return { ...state, resultSendCode: action.resultSendCode };
        }

        case ADD_SEARCH_HISTORY: {
            const updatedSearchHistory = [...new Set([...state.searchHistory, action.searchTerm])];
            localStorage.setItem(SEARCH_HISTORY, JSON.stringify(updatedSearchHistory));
            return {
                ...state,
                searchHistory: updatedSearchHistory
            };
        }

        case REMOVE_SEARCH_HISTORY: {
            const updatedSearchHistory = state.searchHistory.filter(term => term !== action.searchTerm);
            localStorage.setItem(SEARCH_HISTORY, JSON.stringify(updatedSearchHistory));
            return {
                ...state,
                searchHistory: updatedSearchHistory,
            };
        }

        default: return { ...state };
    }
}