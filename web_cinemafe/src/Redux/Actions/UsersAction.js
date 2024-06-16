import Swal from "sweetalert2";
import { userService } from "../../Services/UserService";
import { LOGIN_USER } from "./Type/UserType";

export const LoginUserAction = (loginInfo, navigate) => {
    return async (dispatch) => {
        try {
            const result = await userService.LoginUser(loginInfo);

            if (result.status === 200) {
                dispatch({
                    type: LOGIN_USER,
                    loginInfo: result.data,
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