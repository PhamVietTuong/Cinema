import { baseService } from "./BaseService";

export class UserService extends baseService {
    LoginUser = (loginInfo) => {
        return this.post(`api/Users/LoginUser`, loginInfo)
    }

    RegisterUser = (register) => {
        return this.post(`api/Users/Register`, register)
    }

    ForgetPassword = (sendAuthCode) => {
        return this.post(`api/Users/SendAuthCode`, sendAuthCode )
    }
}

export const userService = new UserService();