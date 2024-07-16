import { Button, FormControl, FormHelperText, FormLabel, IconButton, InputAdornment, OutlinedInput } from '@mui/material';
import './ForgetPassword.css'
import { useEffect, useState } from 'react';
import * as yup from 'yup';
import { ChangePasswordNewAction, ForgetPasswordAction } from '../../../Redux/Actions/UsersAction';
import { useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { Visibility, VisibilityOff } from '@mui/icons-material';

const schemaEmail = yup.object().shape({
    email: yup.string().email("Email không hợp lệ").required('Vui lòng nhập email'),
});

const schemaCode = yup.object().shape({
    code: yup.string().required('Vui lòng nhập mã xác nhận'),
});

const schemaRegister = yup.object().shape({
    password: yup.string()
        .required('Vui lòng nhập mật khẩu')
        .matches(
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/,
            "Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt"
        ),
    confirmPassword: yup.string()
        .required('Vui lòng xác nhận mật khẩu'),
});

const ForgetPassword = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const { resultSendCode, loginInfo } = useSelector((state) => state.UserReducer);
    const [form, setForm] = useState({ email: '', code: '' });
    const [errors, setErrors] = useState({ email: '', code: '' });
    const [step, setStep] = useState(1);

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setForm({ ...form, [name]: value });
    };

    const validateField = async (name, value) => {
        try {
            const schema = name === 'email' ? schemaEmail : schemaCode;
            await yup.reach(schema, name).validate(value);
            setErrors({ ...errors, [name]: '' });
        } catch (error) {
            setErrors({ ...errors, [name]: error.errors[0] });
        }
    };

    const handleSendCode = async () => {
        try {
            await schemaEmail.validate({ email: form.email }, { abortEarly: false });
            dispatch(ForgetPasswordAction({ email: form.email }, navigate));
        } catch (validationErrors) {
            const newErrors = {};
            validationErrors.inner.forEach((error) => {
                newErrors[error.path] = error.message;
            });
            setErrors(newErrors);
        }
    };

    const handleVerifyCode = async () => {
        try {
            await schemaCode.validate({ code: form.code }, { abortEarly: false });
            if (!resultSendCode.isSuccess) {
                setErrors({ ...errors, code: resultSendCode.message });
                return
            }
            const decodedResult = decodeURIComponent(escape(atob(resultSendCode.message)));
            const decodedJson = JSON.parse(decodedResult);
            if (form.code == decodedJson) {
                setStep(3);
            } else {
                setErrors({ ...errors, code: 'Mã xác nhận không đúng' });
            }
        } catch (validationErrors) {
            const newErrors = {};
            validationErrors.inner.forEach((error) => {
                newErrors[error.path] = error.message;
            });
            setErrors(newErrors);
        }
    };

    const [showPasswordRegister, setShowPasswordRegister] = useState(false);
    const [showConfirmPasswordRegister, setShowConfirmPasswordRegister] = useState(false);
    const handleClickShowPasswordRegister = () => setShowPasswordRegister((show) => !show);
    const handleClickShowConfirmPasswordRegister = () => setShowConfirmPasswordRegister((show) => !show);

    const [formRegisterData, setFormRegisterData] = useState({ password: '', confirmPassword: '' });
    const [errorsRegister, setErrorsRegister] = useState({ password: '', confirmPassword: '' });

    const handleInputChangePasswordNew = (event) => {
        const { name, value } = event.target;
        setFormRegisterData({ ...formRegisterData, [name]: value });
    };

    const handleMouseDownPassword = (event) => {
        event.preventDefault();
    };

    const validateFieldPasswordNew = async (name, value) => {
        try {
            await yup.reach(schemaRegister, name).validate(value);
            if (name === 'confirmPassword') {
                const password = formRegisterData.password;
                if (value !== password) {
                    setErrorsRegister({
                        ...errorsRegister,
                        confirmPassword: "Mật khẩu không khớp",
                    });
                    return;
                }
            }
            setErrorsRegister({ ...errorsRegister, [name]: '' });
        } catch (error) {
            setErrorsRegister({ ...errorsRegister, [name]: error.errors[0] });
        }
    };

    const handleChangePasswordNew = async () => {
        try {
            await schemaRegister.validate(formRegisterData, { abortEarly: false });
            dispatch(ChangePasswordNewAction(formRegisterData.password, form.email, navigate));
        } catch (validationErrors) {
            const newErrors = {};
            validationErrors.inner.forEach((error) => {
                newErrors[error.path] = error.message;
            });
            setErrorsRegister(newErrors);
        }
    };

    useEffect(() => {
        if (resultSendCode.isSuccess) {
            setStep(2);
        }
    }, [resultSendCode]);

    return (
        <>
            <section className="forget-password update-pass ht">
                <div className="container">
                    {step === 1 && (
                        <div className="update-pass-wr txt-center mg-auto sec-heading">
                            <h2 className="heading">QUÊN MẬT KHẨU</h2>
                            <p className="desc">Nhập địa chỉ email xác thực tài khoản</p>
                            <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="changePasswordFormControl">
                                <OutlinedInput
                                    className='changePasswordOutlinedInput'
                                    name="email"
                                    placeholder="Email"
                                    onChange={handleInputChange}
                                    onBlur={(event) => validateField(event.target.name, event.target.value)}
                                />
                                {(!!errors.email || !resultSendCode.isSuccess) && (
                                    <FormHelperText>{errors.email || resultSendCode.message}</FormHelperText>
                                )}
                            </FormControl>
                            <Button className="btn btn--pri changePasswordButton" onClick={handleSendCode}>
                                GỬI MÃ XÁC MINH
                            </Button>
                        </div>
                    )}
                    {step === 2 && (
                        <div className="update-pass-wr txt-center mg-auto sec-heading">
                            <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="changePasswordFormControl">
                                <FormLabel sx={{ mb: 1, mt: 2 }} className="forgetPasswordFormLabel">Nhập mã xác nhận <span className="required">*</span></FormLabel>
                                <OutlinedInput
                                    className='changePasswordOutlinedInput'
                                    name="code"
                                    placeholder="Mã xác nhận"
                                    onChange={handleInputChange}
                                    onBlur={(event) => validateField(event.target.name, event.target.value)}
                                />
                                {!!errors.code && (
                                    <FormHelperText>{errors.code}</FormHelperText>
                                )}
                            </FormControl>
                            <Button className="btn btn--pri changePasswordButton" onClick={handleVerifyCode}>
                                XÁC NHẬN
                            </Button>
                        </div>
                    )}
                    {step === 3 && (
                        <div className="update-pass-wr txt-center mg-auto sec-heading">
                            <h2 className="heading">TẠO MẬT KHẨU MỚI</h2>
                            <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="forgetPasswordFormControl">
                                <FormLabel sx={{ mb: 1, mt: 2 }} className="forgetPasswordFormLabel">Nhập mật khẩu mới <span className="required">*</span></FormLabel>
                                <OutlinedInput
                                    type={showPasswordRegister ? 'text' : 'password'}
                                    endAdornment={
                                        <InputAdornment position="end">
                                            <IconButton
                                                onClick={handleClickShowPasswordRegister}
                                                onMouseDown={handleMouseDownPassword}
                                                edge="end"
                                            >
                                                {showPasswordRegister ? <VisibilityOff /> : <Visibility />}
                                            </IconButton>
                                        </InputAdornment>
                                    }
                                    name="password"
                                    placeholder="Mật khẩu mới"
                                    onChange={handleInputChangePasswordNew}
                                    onBlur={(event) => validateFieldPasswordNew(event.target.name, event.target.value)}
                                />
                                {!!errorsRegister.password && (
                                    <FormHelperText>{errorsRegister.password}</FormHelperText>
                                )}
                            </FormControl>
                            <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="forgetPasswordFormControl">
                                <FormLabel sx={{ mb: 1, mt: 2 }} className="forgetPasswordFormLabel">Nhập mật khẩu mới <span className="required">*</span></FormLabel>
                                <OutlinedInput
                                    type={showConfirmPasswordRegister ? 'text' : 'password'}
                                    endAdornment={
                                        <InputAdornment position="end">
                                            <IconButton
                                                onClick={handleClickShowConfirmPasswordRegister}
                                                onMouseDown={handleMouseDownPassword}
                                                edge="end"
                                            >
                                                {showConfirmPasswordRegister ? <VisibilityOff /> : <Visibility />}
                                            </IconButton>
                                        </InputAdornment>
                                    }
                                    name="confirmPassword"
                                    placeholder="Xác thực mật khẩu mới"
                                    onChange={handleInputChangePasswordNew}
                                    onBlur={(event) => validateFieldPasswordNew(event.target.name, event.target.value)}
                                />
                                {!!errorsRegister.confirmPassword && (
                                    <FormHelperText>{errorsRegister.confirmPassword}</FormHelperText>
                                )}
                            </FormControl>
                            <Button className="btn btn--pri changePasswordButton" onClick={handleChangePasswordNew}>
                                ĐỔI MẬT KHẨU
                            </Button>
                        </div>
                    )}
                </div>
            </section>
        </>
    );
}

export default ForgetPassword;
