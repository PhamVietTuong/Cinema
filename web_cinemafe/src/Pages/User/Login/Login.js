import { Label, Visibility, VisibilityOff } from "@mui/icons-material";
import { TabContext, TabList, TabPanel } from "@mui/lab";
import { Box, Button, FormControl, FormLabel, IconButton, InputAdornment, InputLabel, OutlinedInput, Tab, TextField } from "@mui/material";
import { useEffect, useState } from "react";
import './Login.css';
import { useDispatch } from "react-redux";
import { LoginUserAction } from "../../../Redux/Actions/UsersAction";
import { LoginInfo } from "../../../Models/LoginInfo";
import { useNavigate } from "react-router-dom";

const Login = () => {
    const [value, setValue] = useState('login');
    const [userName, setUserName] = useState("");
    const [password, setPassword] = useState("");
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    const [showPassword, setShowPassword] = useState(false);

    const handleClickShowPassword = () => setShowPassword((show) => !show);

    const handleMouseDownPassword = (event) => {
        event.preventDefault();
    };

    const handleLogin = () => {
        let loginInfo = new LoginInfo()
        loginInfo.userName = userName
        loginInfo.password = password
        dispatch(LoginUserAction(loginInfo, navigate));
    }
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
                                        <OutlinedInput onChange={(e) => setUserName(e.target.value)} />
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
                                            onChange={(e) => setPassword(e.target.value)}
                                        />
                                    </FormControl>
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