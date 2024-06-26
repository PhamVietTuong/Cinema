import { Label, Visibility, VisibilityOff } from "@mui/icons-material";
import { TabContext, TabList, TabPanel } from "@mui/lab";
import { Box, Button, Checkbox, FormControl, FormControlLabel, FormHelperText, FormLabel, IconButton, InputAdornment, InputLabel, OutlinedInput, Radio, RadioGroup, Tab, TextField } from "@mui/material";
import { useEffect, useState } from "react";
import './Login.css';
import { useDispatch } from "react-redux";
import { LoginUserAction, RegisterUserAction } from "../../../Redux/Actions/UsersAction";
import { useNavigate } from "react-router-dom";
import * as yup from 'yup';
import { DatePicker, LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import dayjs from "dayjs";
import utc from "dayjs/plugin/utc";
import timezone from "dayjs/plugin/timezone";

const schemaLogin = yup.object().shape({
    userName: yup.string().required('Vui lòng nhập tài khoản, Email hoặc số điện thoại'),
    password: yup.string().required('Vui lòng nhập mật khẩu'),
});

const schemaRegister = yup.object().shape({
    userName: yup.string().required('Vui lòng nhập tên đăng nhập'),
    password: yup.string()
        .required('Vui lòng nhập mật khẩu')
        .matches(
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/,
            "Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt"
        ),
    confirmPassword: yup.string()
        .required('Vui lòng xác nhận mật khẩu'),
    fullName: yup.string().required('Vui lòng nhập họ và tên'),
    email: yup.string().email("Email không hợp lệ").required('Vui lòng nhập email'),
    phone: yup
        .string()
        .required('Vui lòng nhập số điện thoại')
        .matches(/^[0-9]{10}$/, "Số điện thoại không hợp lệ"),
    birthDay: yup.string().required('Vui lòng nhập ngày sinh'),
});

dayjs.extend(utc);
dayjs.extend(timezone);

const Login = () => {
    const [value, setValue] = useState('login');
    const dispatch = useDispatch();
    const navigate = useNavigate();
    //login
    const [formLoginData, setFormLoginData] = useState({
        userName: '',
        password: '',
    });
    const [errorsLogin, setErrorsLogin] = useState({
        userName: '',
        password: '',
    });
    const [rememberMe, setRememberMe] = useState(false);

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    const [showPasswordLogin, setShowPasswordLogin] = useState(false);

    const handleClickShowPasswordLogin = () => setShowPasswordLogin((show) => !show);

    const handleMouseDownPassword = (event) => {
        event.preventDefault();
    };

    const handleInputChangeLogin = (event) => {
        const { name, value } = event.target;
        setFormLoginData({
            ...formLoginData,
            [name]: value,
        });
    };

    const handleLogin = async () => {
        try {
            await schemaLogin.validate(formLoginData, { abortEarly: false });
            dispatch(LoginUserAction(formLoginData, rememberMe, navigate));
        } catch (validationErrors) {
            const newErrors = {};
            validationErrors.inner.forEach((error) => {
                newErrors[error.path] = error.message;
            });
            setErrorsLogin(newErrors);
        }
    }

    const validateFieldLogin = async (name, value) => {
        try {
            await yup.reach(schemaLogin, name).validate(value);
            setErrorsLogin({
                ...errorsLogin,
                [name]: '',
            });
        } catch (error) {
            setErrorsLogin({
                ...errorsLogin,
                [name]: error.errors[0],
            });
        }
    };

    //register
    const [formRegisterData, setFormRegisterData] = useState({
        userName: '',
        fullName: '',
        email: '',
        phone: '',
        birthDay: '',
        password: '',
        confirmPassword: '',
        gender: true,
    });
    const [errorsRegister, setErrorsRegister] = useState({
        userName: '',
        fullName: '',
        email: '',
        phone: '',
        birthDay: '',
        password: '',
        confirmPassword: '',
        gender: true,
    });

    const [showPasswordRegister, setShowPasswordRegister] = useState(false);
    const [showConfirmPasswordRegister, setShowConfirmPasswordRegister] = useState(false);

    const handleClickShowPasswordRegister = () => setShowPasswordRegister((show) => !show);
    const handleClickShowConfirmPasswordRegister = () => setShowConfirmPasswordRegister((show) => !show);

    const handleInputChangeRegister = (event) => {
        const { name, value } = event.target;
        setFormRegisterData({
            ...formRegisterData,
            [name]: value,
        });
    };

    const handleRegister = async () => {
        try {
            await schemaRegister.validate(formRegisterData, { abortEarly: false });
            dispatch(RegisterUserAction(formRegisterData, navigate));
        } catch (validationErrors) {
            const newErrors = {};
            validationErrors.inner.forEach((error) => {
                newErrors[error.path] = error.message;
            });
            setErrorsRegister(newErrors);
        }
    }

    const validateFieldRegister = async (name, value) => {
        try {
            await yup.reach(schemaRegister, name).validate(value);
            if (name === 'confirmPassword') {
                const password = formRegisterData.password;
                if (value !== password) {
                    console.log("Vào");
                    setErrorsRegister({
                        ...errorsRegister,
                        confirmPassword: "Mật khẩu không khớp",
                    });
                    return;
                }
            }
            setErrorsRegister({
                ...errorsRegister,
                [name]: '',
            });
        } catch (error) {
            setErrorsRegister({
                ...errorsRegister,
                [name]: error.errors[0],
            });
        }
    };

    useEffect(() => {
        console.log(errorsRegister);
    }, [errorsRegister]);

    useEffect(() => {
        if (formRegisterData.birthDay) {
            validateFieldRegister('birthDay', formRegisterData.birthDay);
        }
    }, [formRegisterData.birthDay]);

    return (
        <div class="app-content">
            <section className="sec-regis">
                <div className="regis ht">
                    <div className="container">
                        <div className="action-auth tabJS">
                            <TabContext value={value}>
                                <TabList onChange={handleChange} variant="fullWidth" className="loginTabList">
                                    <Tab label="Đăng nhập" value="login" className="loginTab" />
                                    <Tab label="Đăng ký" value="register" className="loginTab" />
                                </TabList>
                                <TabPanel value="login" className="loginTabPanel">
                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1 }} className="loginFormLabel">Tài khoản, Email hoặc số điện thoại <span className="required">*</span></FormLabel>
                                        <OutlinedInput
                                            name="userName"
                                            onChange={handleInputChangeLogin}
                                            onBlur={(event) => validateFieldLogin(event.target.name, event.target.value)}
                                        />
                                        {!!errorsLogin.userName && (
                                            <FormHelperText>{errorsLogin.userName}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Mật khẩu <span className="required">*</span></FormLabel>
                                        <OutlinedInput
                                            type={showPasswordLogin ? 'text' : 'password'}
                                            endAdornment={
                                                <InputAdornment position="end">
                                                    <IconButton
                                                        aria-label="toggle password visibility"
                                                        onClick={handleClickShowPasswordLogin}
                                                        onMouseDown={handleMouseDownPassword}
                                                        edge="end"
                                                    >
                                                        {showPasswordLogin ? <VisibilityOff /> : <Visibility />}
                                                    </IconButton>
                                                </InputAdornment>
                                            }
                                            name="password"
                                            onChange={handleInputChangeLogin}
                                            onBlur={(event) => validateFieldLogin(event.target.name, event.target.value)}
                                        />
                                        {!!errorsLogin.password && (
                                            <FormHelperText>{errorsLogin.password}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControlLabel
                                        control={<Checkbox checked={rememberMe} onChange={(e) => setRememberMe(e.target.checked)} />}
                                        label="Lưu mật khẩu đăng nhập"
                                        className="LoginFormControlLabel"
                                    />

                                    <Button class="btn btn--pri loginButton" onClick={handleLogin}>
                                        Đăng nhập
                                    </Button>
                                </TabPanel>
                                <TabPanel value="register" className="loginTabPanel">
                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1 }} className="loginFormLabel">Họ và tên <span className="required">*</span></FormLabel>
                                        <OutlinedInput
                                            name="fullName"
                                            onChange={handleInputChangeRegister}
                                            onBlur={(event) => validateFieldRegister(event.target.name, event.target.value)}
                                        />
                                        {!!errorsRegister.fullName && (
                                            <FormHelperText>{errorsRegister.fullName}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <LocalizationProvider dateAdapter={AdapterDayjs}>
                                            <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Ngày sinh <span className="required">*</span>
                                            </FormLabel>
                                            <DatePicker
                                                onChange={(date) => setFormRegisterData({ ...formRegisterData, birthDay: dayjs(date).tz('Asia/Ho_Chi_Minh').format('YYYY-MM-DD') })}
                                                onBlur={(event) => validateFieldRegister('birthDay', formRegisterData.birthDay)}
                                                renderInput={(params) => <TextField {...params} />}
                                            />
                                        </LocalizationProvider>
                                        {!!errorsRegister.birthDay && (
                                            <FormHelperText>{errorsRegister.birthDay}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} className="loginFormControl">
                                        <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Gender</FormLabel>
                                        <RadioGroup
                                            row
                                            defaultValue="true"
                                            name="gender"
                                            onChange={handleInputChangeRegister}
                                            className="LoginRadioGroup"
                                        >
                                            <FormControlLabel value="true" control={<Radio />} label="Nam" />
                                            <FormControlLabel value="false" control={<Radio />} label="Nữ" />
                                        </RadioGroup>
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Số điện thoại <span className="required">*</span></FormLabel>
                                        <OutlinedInput
                                            name="phone"
                                            onChange={handleInputChangeRegister}
                                            onBlur={(event) => validateFieldRegister(event.target.name, event.target.value)}
                                        />
                                        {!!errorsRegister.phone && (
                                            <FormHelperText>{errorsRegister.phone}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Tên đăng nhập <span className="required">*</span></FormLabel>
                                        <OutlinedInput
                                            name="userName"
                                            onChange={handleInputChangeRegister}
                                            onBlur={(event) => validateFieldRegister(event.target.name, event.target.value)}
                                        />
                                        {!!errorsRegister.userName && (
                                            <FormHelperText>{errorsRegister.userName}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Email <span className="required">*</span></FormLabel>
                                        <OutlinedInput
                                            name="email"
                                            onChange={handleInputChangeRegister}
                                            onBlur={(event) => validateFieldRegister(event.target.name, event.target.value)}
                                        />
                                        {!!errorsRegister.email && (
                                            <FormHelperText>{errorsRegister.email}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Mật khẩu <span className="required">*</span></FormLabel>
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
                                            onChange={handleInputChangeRegister}
                                            onBlur={(event) => validateFieldRegister(event.target.name, event.target.value)}
                                        />
                                        {!!errorsRegister.password && (
                                            <FormHelperText>{errorsRegister.password}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Xác thực mật khẩu <span className="required">*</span></FormLabel>
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
                                            onChange={handleInputChangeRegister}
                                            onBlur={(event) => validateFieldRegister(event.target.name, event.target.value)}
                                        />
                                        {!!errorsRegister.confirmPassword && (
                                            <FormHelperText>{errorsRegister.confirmPassword}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <Button class="btn btn--pri loginButton" onClick={handleRegister}>
                                        Đăng ký
                                    </Button>
                                </TabPanel>
                            </TabContext>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
}

export default Login;