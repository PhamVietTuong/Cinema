import Swal from "sweetalert2";
import { userService } from "../../Services/UserService";
import { LOGIN_USER } from "./Type/UserType";

export const LoginUserAction = (loginInfo, rememberMe, callBack) => {
    return async (dispatch) => {
        try {
            const result = await userService.LoginUser(loginInfo);

            if (result.status === 200) {
                dispatch({
                    type: LOGIN_USER,
                    loginInfo: result.data,
                    rememberMe: rememberMe
                })
                callBack();
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
                        window.location.reload();
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

export const ForgetPasswordAction = (email, navigate) => {
    return async (dispatch) => {
        try {
            const result = await userService.ForgetPassword(email);

            if (result.status === 200) {
                Swal.fire({
                    title: `ĐẶT LẠI MẬT KHẨU THÀNH CÔNG`,
                    text: "Mật khẩu đã được đặt lại, vui lòng kiểm tra email và tiến hành đăng nhập.",
                    padding: "15px",
                    width: "650px",
                    confirmButtonText: "Đăng nhập",
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