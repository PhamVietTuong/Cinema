import { TOKEN, USER_LOGIN } from "../../Ustil/Settings/Config";
import { LOGIN_USER } from "../Actions/Type/UserType";

let user = {};
if (localStorage.getItem(USER_LOGIN)) {
    user = JSON.parse(localStorage.getItem(USER_LOGIN));
}

const stateDefault = {
    loginInfo: user
}

export const UserReducer = (state = stateDefault, action) => {
    switch (action.type) {
        case LOGIN_USER: {
            const { loginInfo } = action;
            localStorage.setItem(USER_LOGIN, JSON.stringify(loginInfo));
            localStorage.setItem(TOKEN, loginInfo.token);
            return { ...state, loginInfo: loginInfo };
        }

        default: return { ...state };
    }
}