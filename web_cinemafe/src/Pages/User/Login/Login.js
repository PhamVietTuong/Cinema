import { Label, Visibility, VisibilityOff } from "@mui/icons-material";
import { TabContext, TabList, TabPanel } from "@mui/lab";
import { Box, Button, Checkbox, FormControl, FormControlLabel, FormHelperText, FormLabel, IconButton, InputAdornment, InputLabel, OutlinedInput, Tab, TextField } from "@mui/material";
import { useEffect, useState } from "react";
import './Login.css';
import { useDispatch } from "react-redux";
import { LoginUserAction } from "../../../Redux/Actions/UsersAction";
import { LoginInfo } from "../../../Models/LoginInfo";
import { useNavigate } from "react-router-dom";
import * as yup from 'yup';

const schema = yup.object().shape({
    userName: yup.string().required('Vui lòng nhập tài khoản, Email hoặc số điện thoại'),
    password: yup.string().required('Vui lòng nhập mật khẩu'),
});

const Login = () => {
    const [value, setValue] = useState('login');
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const [formData, setFormData] = useState({
        userName: '',
        password: '',
    });
    const [errors, setErrors] = useState({
        userName: '',
        password: '',
    });
    const [rememberMe, setRememberMe] = useState(false); 

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    const [showPassword, setShowPassword] = useState(false);

    const handleClickShowPassword = () => setShowPassword((show) => !show);

    const handleMouseDownPassword = (event) => {
        event.preventDefault();
    };

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setFormData({
            ...formData,
            [name]: value,
        });
    };

    const handleLogin = async () => {
        try {
            await schema.validate(formData, { abortEarly: false });
            dispatch(LoginUserAction(formData, rememberMe, navigate));
        } catch (validationErrors) {
            const newErrors = {};
            validationErrors.inner.forEach((error) => {
                newErrors[error.path] = error.message;
            });
            setErrors(newErrors);
        }
    }

    const validateField = async (name, value) => {
        try {
            await yup.reach(schema, name).validate(value);
            setErrors({
                ...errors,
                [name]: '',
            });
        } catch (error) {
            setErrors({
                ...errors,
                [name]: error.errors[0],
            });
        }
    };

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
                                            onChange={handleInputChange} 
                                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                                        />
                                        {!!errors.userName && (
                                            <FormHelperText>{errors.userName}</FormHelperText>
                                        )}
                                    </FormControl>

                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <FormLabel sx={{ mb: 1, mt: 2 }} className="loginFormLabel">Mật khẩu <span className="required">*</span></FormLabel>
                                        <OutlinedInput
                                            type={showPassword ? 'text' : 'password'}
                                            endAdornment={
                                                <InputAdornment position="end">
                                                    <IconButton
                                                        aria-label="toggle password visibility"
                                                        onClick={handleClickShowPassword}
                                                        onMouseDown={handleMouseDownPassword}
                                                        edge="end"
                                                    >
                                                        {showPassword ? <VisibilityOff /> : <Visibility />}
                                                    </IconButton>
                                                </InputAdornment>
                                            }
                                            name="password"
                                            onChange={handleInputChange} 
                                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                                        />
                                        {!!errors.password && (
                                            <FormHelperText>{errors.password}</FormHelperText>
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
                                <TabPanel value="register">Item Two</TabPanel>
                            </TabContext>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
}

export default Login;