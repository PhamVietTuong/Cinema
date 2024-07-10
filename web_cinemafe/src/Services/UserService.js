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

    UpdateUser = (userDTO) => {
        return this.post(`api/Users/UpdateUser`, userDTO )
    }

    ChangePassword = (changePassword, userName) => {
        return this.post(`api/Users/ChangePassword?changePassword=${changePassword}&userName=${userName}`);
    }    

    GetListUser = () => {
        return this.get(`api/Users/GetListUser`)
    }
}

export const userService = new UserService();