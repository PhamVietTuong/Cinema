import Swal from "sweetalert2";
import { userService } from "../../Services/UserService";
import { ADD_SEARCH_HISTORY, LOGIN_USER, LOGOUT, SET_LIST_USER, SET_RESULT_SEND_CODE } from "./Type/UserType";

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
                dispatch({
                    type: SET_RESULT_SEND_CODE,
                    resultSendCode: result.data,
                })
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


export const ChangePasswordNewAction = (changePassword, userName, navigate) => {
    return async (dispatch) => {
        try {
            const result = await userService.ChangePassword(changePassword, userName, navigate);
            if (result.status === 200) {
                await Swal.fire({
                    padding: "24px",
                    width: "400px",
                    title: "Đổi mật khẩu thành công, vui lòng đăng nhập lại!",
                    confirmButtonText: "OK",
                }).then(() => {
                    navigate("/login");
                });
            }
        } catch (error) {
            await Swal.fire({
                padding: "24px",
                width: "400px",
                title: "Đã xảy ra lỗi!",
                confirmButtonText: "Ok",
            }).then((result) => {
                if (result.isConfirmed) {
                    console.log("UpdateUserAction: ", error);
                }
            });
        }
    }
}

export const UpdateUserAction = (userDTO) => {
    return async (dispatch) => {
        try {
            const result = await userService.UpdateUser(userDTO);
            if (result.status === 200) {
                await Swal.fire({
                    padding: "24px",
                    width: "400px",
                    title: "Cập nhật thành công, vui lòng đăng nhập lại!",
                    confirmButtonText: "OK",
                }).then(() => {
                    dispatch({
                        type: LOGOUT,
                    })
                    window.location.href = '/login';
                });
            }
        } catch (error) {
            await Swal.fire({
                text: error.response.data,
                padding: "15px",
                width: "425px",
                confirmButtonText: "Thử lại",
            }).then((result) => {
                if (result.isConfirmed) {
                    console.log("UpdateUserAction: ", error);
                }
            });
        }
    }
}

export const ChangePasswordAction = (changePassword, userName) => {
    return async (dispatch) => {
        try {
            const result = await userService.ChangePassword(changePassword, userName);
            if (result.status === 200) {
                await Swal.fire({
                    padding: "24px",
                    width: "400px",
                    title: "Cập nhật thành công, vui lòng đăng nhập lại!",
                    confirmButtonText: "OK",
                }).then(() => {
                    dispatch({
                        type: LOGOUT,
                    })
                    window.location.href = '/login';
                });
            }
        } catch (error) {
            await Swal.fire({
                padding: "24px",
                width: "400px",
                title: "Đã xảy ra lỗi!",
                confirmButtonText: "Ok",
            }).then((result) => {
                if (result.isConfirmed) {
                    console.log("UpdateUserAction: ", error);
                }
            });
        }
    }
}

export const GetListUserAction = (code) => {
    return async (dispatch) => {
        try {
            const result = await userService.GetListUser(code);
            dispatch({
                type: SET_LIST_USER,
                listUser: result.data,
            })
        } catch (error) {
            await Swal.fire({
                padding: "24px",
                width: "400px",
                title: "Đã xảy ra lỗi!",
                confirmButtonText: "Ok",
            }).then((result) => {
                if (result.isConfirmed) {
                    console.log("GetListUserAction: ", error);
                }
            });
        }
    }
}

export const CreateUserAction = (register) => {
    return async (dispatch) => {
        try {
            const result = await userService.RegisterUser(register);

            if (result.status === 200) {
                Swal.fire({
                    text: "Thêm thành công!",
                    padding: "15px",
                    width: "350px",
                    confirmButtonText: "Ok",
                }).then((result) => {
                    if (result.isConfirmed) {
                        dispatch(GetListUserAction());
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
            console.log("CreateUserAction: ", error);
        }
    }
}

export const AddSearchHistoryAction = (searchTerm) => {
    return {
        type: ADD_SEARCH_HISTORY,
        searchTerm,
    };
}