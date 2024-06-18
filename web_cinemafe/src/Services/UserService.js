import { baseService } from "./BaseService";

export class UserService extends baseService {
    LoginUser = (loginInfo) => {
        return this.post(`api/Users/LoginUser`, loginInfo)
    }
}

export const userService = new UserService();