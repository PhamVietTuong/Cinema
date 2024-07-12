import { TOKEN, USER_LOGIN } from "../../Ustil/Settings/Config";
import { LOGIN_USER, LOGOUT, REGISTER_USER, SET_LIST_USER, SET_RESULT_SEND_CODE } from "../Actions/Type/UserType";

let user = {};
if (localStorage.getItem(USER_LOGIN) || sessionStorage.getItem(USER_LOGIN)) {
    user = JSON.parse(localStorage.getItem(USER_LOGIN) || sessionStorage.getItem(USER_LOGIN));
}

const stateDefault = {
    loginInfo: user,
    isLoggedIn: Object.keys(user).length !== 0,
    userId: user.phone,
    listUser: [],
    resultSendCode: {}
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
            console.log(action.resultSendCode);
            return { ...state, resultSendCode: action.resultSendCode };
        }

        default: return { ...state };
    }
}