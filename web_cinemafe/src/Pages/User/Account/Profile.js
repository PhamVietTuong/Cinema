import Tab from '@mui/material/Tab';
import Box from '@mui/material/Box';
import './Profile.css'
import PersonIcon from '@mui/icons-material/Person';
import { useEffect, useState } from 'react';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import LogoutIcon from '@mui/icons-material/Logout';
import { Button, Divider, Grid, IconButton, InputAdornment, Tabs, TextField, Typography } from '@mui/material';
import { LOGOUT } from '../../../Redux/Actions/Type/UserType';
import { useDispatch, useSelector } from 'react-redux';
import * as yup from 'yup';
import { ChangePasswordAction, UpdateUserAction } from '../../../Redux/Actions/UsersAction';
import { Table } from 'react-bootstrap';
import { GetInvoiceListAction } from '../../../Redux/Actions/CinemasAction';
import TicketInfo from '../../../Components/ticketInfo/TicketInfo';
import moment from 'moment';

const schema = yup.object().shape({
    fullName: yup.string().required('Vui lòng điền thông tin!'),
    birthDay: yup.date().max(new Date(), 'Ngày sinh phải nhỏ hơn ngày hiện tại!').required('Vui lòng điền thông tin!'),
    phone: yup.string().matches(/^\d+$/, 'Số điện thoại phải là số!').required('Vui lòng điền thông tin!'),
    email: yup.string().email('Email không hợp lệ').required('Vui lòng điền thông tin!'),
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

    const [value, setValue] = useState('0');

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    const [formData, setFormData] = useState({
        id: loginInfo.id,
        fullName: loginInfo.fullName,
        birthDay: loginInfo.birthDay,
        gender: loginInfo.gender,
        phone: loginInfo.phone,
        email: loginInfo.email,
    });

    const [passwordData, setPasswordData] = useState({
        userName: loginInfo.userName,
        oldPassword: '',
        changePassword: '',
        repeatPassword: '',
    });

    const [errors, setErrors] = useState({
        fullName: '',
        birthDay: '',
        phone: '',
        email: '',
    });

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setFormData({
            ...formData,
            [name]: value,
        });
    };

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

    const handleSubmit = async () => {
        try {
            await schema.validate(formData, { abortEarly: false });
            dispatch(UpdateUserAction(formData));
        } catch (error) {
            console.error('Validation Error:', error.errors);
            error.inner.forEach(err => {
                setErrors({
                    ...errors,
                    [err.path]: err.message,
                });
            });
        }
    };

    const handleInputChangePassword = (event) => {
        const { name, value } = event.target;
        setPasswordData({
            ...passwordData,
            [name]: value,
        });
    };

    const handleSubmitChangePassword = async () => {
        try {
            // await schema.validate(passwordData, { abortEarly: false });
            dispatch(ChangePasswordAction(passwordData.changePassword, passwordData.userName));
        } catch (error) {
            console.error('Validation Error:', error.errors);
            error.inner.forEach(err => {
                setErrors({
                    ...errors,
                    [err.path]: err.message,
                });
            });
        }
    };

    const { listInvoiceByUser } = useSelector((state) => state.CinemasReducer)

    useEffect(() => {
        dispatch(GetInvoiceListAction(loginInfo.id));
    }, [dispatch]);

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
                                                value={formData.fullName}
                                                onChange={handleInputChange}
                                                onBlur={(event) => validateField(event.target.name, event.target.value)}
                                                error={!!errors.fullName}
                                                helperText={errors.fullName} />
                                            <TextField
                                                sx={{ mt: 2 }}
                                                fullWidth
                                                label="Ngày sinh"
                                                type="date"
                                                name='birthDay'
                                                InputLabelProps={{ shrink: true }}
                                                value={formatDate(formData.birthDay)}
                                                onChange={handleInputChange}
                                                onBlur={(event) => validateField(event.target.name, event.target.value)}
                                                error={!!errors.birthDay}
                                                helperText={errors.birthDay} />
                                        </Grid>
                                        <Grid item xs={6}>
                                            <TextField
                                                fullWidth
                                                label="Số điện thoại"
                                                name='phone'
                                                value={formData.phone}
                                                onChange={handleInputChange}
                                                onBlur={(event) => validateField(event.target.name, event.target.value)}
                                                error={!!errors.phone}
                                                helperText={errors.phone} />
                                            <TextField
                                                sx={{ mt: 2 }}
                                                fullWidth
                                                label="Email"
                                                name='email'
                                                value={formData.email}
                                                onChange={handleInputChange}
                                                onBlur={(event) => validateField(event.target.name, event.target.value)}
                                                error={!!errors.email}
                                                helperText={errors.email} />
                                        </Grid>
                                    </Grid>
                                    <Button className='save-info' onClick={handleSubmit}>LƯU THÔNG TIN</Button>
                                </Box>
                                <Divider sx={{ my: 4 }} />
                                <Box component="form" sx={{ display: 'flex', flexDirection: 'column', gap: 2 }} className='profileBox'>
                                    <Typography variant="h4" className='profileTypography sec-heading'>
                                        <div className='heading info'>
                                            Đổi mật khẩu
                                        </div>
                                    </Typography>
                                    <TextField
                                        fullWidth
                                        label="Mật khẩu cũ"
                                        type="password"
                                        name='oldPassword'
                                        InputLabelProps={{ shrink: true }}
                                        value={(passwordData.oldPassword)}
                                        onChange={handleInputChangePassword}
                                    // onBlur={(event) => validateField(event.target.name, event.target.value)}
                                    // error={!!errors.oldPassword}
                                    // helperText={errors.oldPassword} 
                                    />
                                    <TextField
                                        fullWidth
                                        label="Mật khẩu mới"
                                        type="password"
                                        name='changePassword'
                                        InputLabelProps={{ shrink: true }}
                                        value={passwordData.changePassword}
                                        onChange={handleInputChangePassword}                                      
                                    // onBlur={(event) => validateField(event.target.name, event.target.value)}
                                    // error={!!errors.changePassword}
                                    // helperText={errors.changePassword} 
                                    />
                                    <TextField
                                        fullWidth
                                        label="Xác thực mật khẩu"
                                        type="password"
                                        name='repeatPassword'
                                        InputLabelProps={{ shrink: true }}
                                        value={passwordData.repeatPassword}
                                        onChange={handleInputChangePassword}
                                    // onBlur={(event) => validateField(event.target.name, event.target.value)}
                                    // error={!!errors.repeatPassword}
                                    // helperText={errors.repeatPassword} 
                                    />
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
