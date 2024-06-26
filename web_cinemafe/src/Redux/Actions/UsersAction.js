import Swal from "sweetalert2";
import { userService } from "../../Services/UserService";
import { LOGIN_USER, REGISTER_USER } from "./Type/UserType";

export const LoginUserAction = (loginInfo, rememberMe, navigate) => {
    return async (dispatch) => {
        try {
            const result = await userService.LoginUser(loginInfo);

            if (result.status === 200) {
                dispatch({
                    type: LOGIN_USER,
                    loginInfo: result.data,
                    rememberMe: rememberMe
                })

                Swal.fire({
                    text: "Đăng nhập thành công!",
                    padding: "15px",
                    width: "350px",
                    confirmButtonText: "Ok",
                }).then((result) => {
                    if (result.isConfirmed) {
                        navigate(-1);
                    }
                });
            }
           
        } catch (error) {
            Swal.fire({
                text: error.response.data,
                padding: "15px",
                width: "425px",
                confirmButtonText: "Thử lại",
            });
            console.log("LoginUserAction: ", error);
        }
    }
}

export const RegisterUserAction = (register, navigate) => {
    return async (dispatch) => {
        try {
            const result = await userService.RegisterUser(register);

            if (result.status === 200) {
                Swal.fire({
                    text: "Đăng ký thành công!",
                    padding: "15px",
                    width: "350px",
                    confirmButtonText: "Ok",
                }).then((result) => {
                    if (result.isConfirmed) {
                        navigate("/login");
                    }
                });
            }

        } catch (error) {
            Swal.fire({
                text: error.response.data,
                padding: "15px",
                width: "425px",
                confirmButtonText: "Thử lại",
            });
            console.log("LoginUserAction: ", error);
        }
    }
}