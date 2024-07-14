import Tab from '@mui/material/Tab';
import Box from '@mui/material/Box';
import './Profile.css'
import PersonIcon from '@mui/icons-material/Person';
import { useEffect, useState } from 'react';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import LogoutIcon from '@mui/icons-material/Logout';
import { Button, Divider, FormControl, FormHelperText, Grid, IconButton, InputAdornment, InputLabel, MenuItem, OutlinedInput, Select, Tabs, TextField, Typography } from '@mui/material';
import { LOGOUT } from '../../../Redux/Actions/Type/UserType';
import { useDispatch, useSelector } from 'react-redux';
import * as yup from 'yup';
import { ChangePasswordAction, LoginUserAction, UpdateUserAction } from '../../../Redux/Actions/UsersAction';
import { Table } from 'react-bootstrap';
import { GetInvoiceListAction } from '../../../Redux/Actions/CinemasAction';
import TicketInfo from '../../../Components/ticketInfo/TicketInfo';
import moment from 'moment';
import { Visibility, VisibilityOff } from '@mui/icons-material';
import Swal from 'sweetalert2';

const schemaChangeInfo = yup.object().shape({
    fullName: yup.string().required('Vui lòng điền thông tin!'),
    birthDay: yup.date().max(new Date(), 'Ngày sinh phải nhỏ hơn ngày hiện tại!').required('Vui lòng điền thông tin!'),
    email: yup.string().email('Email không hợp lệ').required('Vui lòng điền thông tin!'),
});

const schemaChangePassword = yup.object().shape({
    oldPassword: yup.string().required('Vui lòng nhập mật khẩu cũ'),
    changePassword: yup.string()
        .required('Vui lòng nhập mật khẩu')
        .matches(
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/,
            "Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt"
        ),
    repeatPassword: yup.string()
        .required('Vui lòng xác nhận mật khẩu mới'),
});

const formatDate = (dateString) => {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

const formatDateShow = (dateString) => {
    if (!dateString) return "";
    const formattedDate = moment(dateString).locale("vi").format("dddd DD/MM/yyyy");
    return formattedDate.charAt(0).toUpperCase() + formattedDate.slice(1);
};

const formatCurrency = (value) => {
    if (!value) return 0;
    return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
};

const Profile = () => {
    const dispatch = useDispatch();

    const {
        loginInfo,
    } = useSelector((state) => state.UserReducer);

    //Chuyển giao diện
    const [value, setValue] = useState('0');

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    /*** Form thông tin cá nhân ***/
    const [infoData, setInfoData] = useState({
        fullName: loginInfo.fullName,
        birthDay: loginInfo.birthDay,
        gender: loginInfo.gender,
        phone: loginInfo.phone,
        email: loginInfo.email,
    });

    const [errorsChangeInfo, setErrorsChangeInfo] = useState({
        fullName: '',
        birthDay: '',
        email: '',
    });

    const [isInfoDataChanged, setIsInfoDataChanged] = useState(false);

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setInfoData({
            ...infoData,
            [name]: value,
        });
        setIsInfoDataChanged(true);
    };

    const validateChangeInfo = async (name, value) => {
        try {
            await yup.reach(schemaChangeInfo, name).validate(value);
            setErrorsChangeInfo({
                ...errorsChangeInfo,
                [name]: '',
            });
        } catch (error) {
            setErrorsChangeInfo({
                ...errorsChangeInfo,
                [name]: error.errors[0],
            });
        }
    };

    const handleSubmitChangeInfo = async () => {
        if (isInfoDataChanged) {
            try {
                await schemaChangeInfo.validate(infoData, { abortEarly: false });
                dispatch(UpdateUserAction(infoData));
            } catch (error) {
                console.error('Validation Error:', error.errors);
                error.inner.forEach(err => {
                    setErrorsChangeInfo({
                        ...errorsChangeInfo,
                        [err.path]: err.message,
                    });
                });
            }
            setIsInfoDataChanged(false);
        }
        else {
            await Swal.fire({
                padding: "24px",
                width: "400px",
                title: "Vui lòng thay đổi thông tin!",
                confirmButtonText: "OK",
            })
        }
    };

    /*** Form đổi mật khẩu ***/
    const [showOldPasswor, setShowOldPasswor] = useState(false);
    const [showChangePassword, setShowChangePassword] = useState(false);
    const [showRepeatPassword, setShowRepeatPassword] = useState(false);

    const handleClickShowOldPasswor = () => setShowOldPasswor((show) => !show);
    const handleClickShowChangePassword = () => setShowChangePassword((show) => !show);
    const handleClickShowRepeatPassword = () => setShowRepeatPassword((show) => !show);

    const handleMouseDownPassword = (event) => {
        event.preventDefault();
    };

    const [passwordData, setPasswordData] = useState({
        phone: loginInfo.phone,
        oldPassword: '',
        changePassword: '',
        repeatPassword: '',
    });

    const [errorsChangePassword, setErrorsChangePassword] = useState({
        oldPassword: '',
        changePassword: '',
        repeatPassword: '',
    });

    const [isChangePasswordDataChanged, setIsChangePasswordInfoDataChanged] = useState(false);

    const handleInputChangePassword = (event) => {
        const { name, value } = event.target;
        setPasswordData({
            ...passwordData,
            [name]: value,
        });
        setIsChangePasswordInfoDataChanged(true);
    };

    const validateChangePassword = async (name, value) => {
        try {
            await yup.reach(schemaChangePassword, name).validate(value);
            if (name === 'repeatPassword') {
                const password = passwordData.changePassword;
                if (value !== password) {
                    setErrorsChangePassword({
                        ...errorsChangePassword,
                        repeatPassword: "Mật khẩu không khớp",
                    });
                    return;
                }
            }
            setErrorsChangePassword({
                ...errorsChangePassword,
                [name]: '',
            });
        } catch (error) {
            setErrorsChangePassword({
                ...errorsChangePassword,
                [name]: error.errors[0],
            });
        }
    };

    const handleSubmitChangePassword = async () => {
        if (isChangePasswordDataChanged) {
            try {
                await schemaChangePassword.validate(passwordData, { abortEarly: false });
                if (errorsChangePassword.repeatPassword) {
                    return;
                }
                dispatch(LoginUserAction({ username: infoData.phone, password: passwordData.oldPassword }, false, () => {
                    dispatch(ChangePasswordAction(passwordData.changePassword, passwordData.phone));
                }));
            } catch (error) {
                console.error('Validation Error:', error.errorsChangePassword);
                error.inner.forEach(err => {
                    setErrorsChangePassword({
                        ...errorsChangePassword,
                        [err.path]: err.message,
                    });
                });
            }
        } else {
            await Swal.fire({
                padding: "24px",
                width: "400px",
                title: "Vui lòng nhập mật khẩu!",
                confirmButtonText: "OK",
            })
        }
    };

    /*** Trang lịch sử mua hàng ****/
    const { listInvoiceByUser } = useSelector((state) => state.CinemasReducer)

    useEffect(() => {
        dispatch(GetInvoiceListAction(loginInfo.phone));
    }, [dispatch, loginInfo.phone]);

    const [openTicketInfo, setOpenTickInfo] = useState(false);
    const [codeOfInvoice, setCodeOfInvoice] = useState({});

    const handleSeeTicketClick = (row) => {
        setCodeOfInvoice(row);
        setOpenTickInfo(true);
    };

    const handleSeeTicketClose = () => {
        setCodeOfInvoice({});
        setOpenTickInfo(false);
    };

    return (
        <>
            <div className='container'>
                <Box sx={{ display: 'flex', minHeight: '100vh' }}>
                    <Box sx={{ width: '270px', height: '320px', bgcolor: '#3f51b5', color: 'white', p: 2 }} className='profileTabList'>
                        <div className='icon-name'>
                            <img className="icon" src="https://cinestar.monamedia.net/assets/images/ic-header-auth.svg" alt="" />
                            <Typography variant="h6">{loginInfo.fullName}</Typography>
                        </div>
                        <Divider sx={{ my: 2, borderColor: 'rgba(248, 250, 252, .2)', opacity: 1 }} />
                        <Tabs
                            className='tag'
                            orientation="vertical"
                            value={value}
                            onChange={handleChange}
                            textColor="inherit"
                            indicatorColor="none"
                            sx={{
                                '& .MuiTab-root': {
                                    textTransform: 'none',
                                    alignItems: 'flex-start',
                                    justifyContent: 'flex-start',
                                    minHeight: '44.8px',
                                    height: '44.8px',
                                    color: '#fff',
                                    '&.Mui-selected': {
                                        borderLeft: '2px solid #f3ea28',
                                        color: '#f3ea28'
                                    }
                                }
                            }}
                        >
                            <Tab className='info-customer' label="Thông tin khách hàng" icon={<PersonIcon />} iconPosition="start" value='0' />
                            <Tab className='history' label="Lịch sử mua hàng" icon={<ShoppingCartIcon />} iconPosition="start" value='1' />
                        </Tabs>
                        <Divider sx={{ my: 2, borderColor: 'rgba(248, 250, 252, .2)', opacity: 1 }} />
                        <p className='log-out' onClick={() => {
                            dispatch({
                                type: LOGOUT,
                            })
                        }}>{<LogoutIcon />}<span>Đăng xuất</span></p>
                    </Box>
                    <Box sx={{ flexGrow: 1, p: 3 }}>
                        {value === '0' && (
                            <Box className='info-customer'>
                                <Typography variant="h4" className='profileTypography sec-heading'>
                                    <div className='heading customer'>
                                        Thông tin khách hàng
                                    </div>
                                </Typography>
                                <Divider sx={{ my: 2 }} />
                                <Box component="form" sx={{ display: 'flex', flexDirection: 'column', gap: 2 }} className='profileBox'>
                                    <Typography variant="h4" className='profileTypography sec-heading'>
                                        <div className='heading info'>
                                            Thông tin cá nhân
                                        </div>
                                    </Typography>
                                    <Grid container spacing={2}>
                                        <Grid item xs={6}>
                                            <TextField
                                                fullWidth
                                                label="Họ và tên"
                                                name='fullName'
                                                value={infoData.fullName}
                                                onChange={handleInputChange}
                                                onBlur={(event) => validateChangeInfo(event.target.name, event.target.value)}
                                                error={!!errorsChangeInfo.fullName}
                                                helperText={errorsChangeInfo.fullName} />
                                            <TextField
                                                sx={{ mt: 2 }}
                                                fullWidth
                                                label="Ngày sinh"
                                                type="date"
                                                name='birthDay'
                                                InputLabelProps={{ shrink: true }}
                                                value={formatDate(infoData.birthDay)}
                                                onChange={handleInputChange}
                                                onBlur={(event) => validateChangeInfo(event.target.name, event.target.value)}
                                                error={!!errorsChangeInfo.birthDay}
                                                helperText={errorsChangeInfo.birthDay} />
                                        </Grid>
                                        <Grid item xs={6}>
                                            <FormControl fullWidth>
                                                <InputLabel>Giới tính</InputLabel>
                                                <Select
                                                    label="Giới tính"
                                                    name="gender"
                                                    value={infoData.gender}
                                                    onChange={handleInputChange}
                                                >
                                                    <MenuItem value={true}>Nam</MenuItem>
                                                    <MenuItem value={false}>Nữ</MenuItem>
                                                </Select>
                                            </FormControl>
                                            <TextField
                                                sx={{ mt: 2 }}
                                                fullWidth
                                                label="Email"
                                                name='email'
                                                value={infoData.email}
                                                onChange={handleInputChange}
                                                onBlur={(event) => validateChangeInfo(event.target.name, event.target.value)}
                                                error={!!errorsChangeInfo.email}
                                                helperText={errorsChangeInfo.email} />
                                        </Grid>
                                    </Grid>
                                    <Button className='save-info' onClick={handleSubmitChangeInfo}>LƯU THÔNG TIN</Button>
                                </Box>
                                <Divider sx={{ my: 4 }} />
                                <Box component="form" sx={{ display: 'flex', flexDirection: 'column', gap: 2 }} className='profileBox'>
                                    <Typography variant="h4" className='profileTypography sec-heading'>
                                        <div className='heading info'>
                                            Đổi mật khẩu
                                        </div>
                                    </Typography>
                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <InputLabel htmlFor="changePassword" className="inputFormChangPassword">Mật khẩu cũ</InputLabel>
                                        <OutlinedInput
                                            type={showOldPasswor ? 'text' : 'password'}
                                            endAdornment={
                                                <InputAdornment position="end">
                                                    <IconButton
                                                        onClick={handleClickShowOldPasswor}
                                                        onMouseDown={handleMouseDownPassword}
                                                        edge="end"
                                                    >
                                                        {showOldPasswor ? <VisibilityOff /> : <Visibility />}
                                                    </IconButton>
                                                </InputAdornment>
                                            }
                                            label="Mật khẩu cũ"
                                            name="oldPassword"
                                            onChange={handleInputChangePassword}
                                            onBlur={(event) => validateChangePassword(event.target.name, event.target.value)}
                                        />
                                        {!!errorsChangePassword.oldPassword && (
                                            <FormHelperText>{errorsChangePassword.oldPassword}</FormHelperText>
                                        )}
                                    </FormControl>
                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <InputLabel htmlFor="changePassword" className="inputFormChangPassword">Mật khẩu mới</InputLabel>
                                        <OutlinedInput
                                            type={showChangePassword ? 'text' : 'password'}
                                            endAdornment={
                                                <InputAdornment position="end">
                                                    <IconButton
                                                        onClick={handleClickShowChangePassword}
                                                        onMouseDown={handleMouseDownPassword}
                                                        edge="end"
                                                    >
                                                        {showChangePassword ? <VisibilityOff /> : <Visibility />}
                                                    </IconButton>
                                                </InputAdornment>
                                            }
                                            label="Mật khẩu mới"
                                            name="changePassword"
                                            onChange={handleInputChangePassword}
                                            onBlur={(event) => validateChangePassword(event.target.name, event.target.value)}
                                        />
                                        {!!errorsChangePassword.changePassword && (
                                            <FormHelperText>{errorsChangePassword.changePassword}</FormHelperText>
                                        )}
                                    </FormControl>
                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="loginFormControl">
                                        <InputLabel htmlFor="changePassword" className="inputFormChangPassword">Xác thực mật khẩu</InputLabel>
                                        <OutlinedInput
                                            type={showRepeatPassword ? 'text' : 'password'}
                                            endAdornment={
                                                <InputAdornment position="end">
                                                    <IconButton
                                                        onClick={handleClickShowRepeatPassword}
                                                        onMouseDown={handleMouseDownPassword}
                                                        edge="end"
                                                    >
                                                        {showRepeatPassword ? <VisibilityOff /> : <Visibility />}
                                                    </IconButton>
                                                </InputAdornment>
                                            }
                                            label="Xác thực mật khẩu"
                                            name="repeatPassword"
                                            onChange={handleInputChangePassword}
                                            onBlur={(event) => validateChangePassword(event.target.name, event.target.value)}
                                        />
                                        {!!errorsChangePassword.repeatPassword && (
                                            <FormHelperText>{errorsChangePassword.repeatPassword}</FormHelperText>
                                        )}
                                    </FormControl>
                                    <Button className='change-password' onClick={handleSubmitChangePassword}>ĐỔI MẬT KHẨU</Button>
                                </Box>
                            </Box>
                        )}
                        {value === '1' && (
                            <Box>
                                <Typography variant="h4" className='profileTypography sec-heading'>
                                    <div className='heading customer'>
                                        LỊCH SỬ MUA HÀNG
                                    </div>
                                </Typography>
                                {listInvoiceByUser.length <= 0 ? (
                                    <p className='no-data'>Không có dữ liệu</p>
                                ) : (
                                    <Table bordered className='table-history'>
                                        <thead>
                                            <tr>
                                                <th>Mã đơn</th>
                                                <th>Chi nhánh</th>
                                                <th>Ngày</th>
                                                <th>Tổng cộng</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {listInvoiceByUser.map((item, index) => (
                                                <tr key={index}>
                                                    <td>{item.code}</td>
                                                    <td>{item.theaterName}</td>
                                                    <td>{formatDateShow(item.showTimeStartTime)}</td>
                                                    <td>{formatCurrency(item.totalPrice)}</td>
                                                    <td style={{ color: '#9c9c9c', cursor: 'pointer' }} onClick={() => handleSeeTicketClick(item)} >Xem vé</td>
                                                </tr>
                                            ))
                                            }
                                        </tbody>
                                    </Table>
                                )}
                            </Box>
                        )}
                    </Box>
                </Box>
            </div>
            <TicketInfo
                show={openTicketInfo}
                handleClose={handleSeeTicketClose}
                row={codeOfInvoice}
            />
        </>
    );
}

export default Profile;
