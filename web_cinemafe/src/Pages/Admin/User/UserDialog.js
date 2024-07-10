import { Button, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, FormControl, FormControlLabel, InputLabel, MenuItem, Select, Switch, TextField } from "@mui/material";
import { Fragment, useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { CreateUserAction } from "../../../Redux/Actions/UsersAction";
import { GetUserTypeListAction } from "../../../Redux/Actions/CinemasAction";
import * as yup from 'yup';

const CurrentDate = () => {
    const today = new Date();
    const day = String(today.getDate()).padStart(2, '0');
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const year = today.getFullYear();
    const formattedDate = `${year}-${month}-${day}`;
    return formattedDate;
};

const schema = yup.object().shape({
    fullName: yup.string().required('Vui lòng điền thông tin!'),
    email: yup.string().email('Email không hợp lệ').required('Vui lòng điền thông tin!'),
    phone: yup.string().matches(/^\d+$/, 'Số điện thoại phải là số!').required('Vui lòng điền thông tin!'),
    birthDay: yup.date().max(new Date(), 'Ngày sinh phải nhỏ hơn ngày hiện tại!').required('Vui lòng điền thông tin!'),
    userName: yup.string().required('Vui lòng điền thông tin!'),
    password: yup.string().required('Vui lòng điền thông tin!'),
    confirmPassword: yup.string().required('Vui lòng điền thông tin!'),
});

const UserDialog = ({ open, onClose }) => {
    const dispatch = useDispatch();

    const { userTypeList } = useSelector((state) => state.CinemasReducer)

    useEffect(() => {
        dispatch(GetUserTypeListAction());
    }, [dispatch]);

    const [formData, setFormData] = useState({
        userTypeName: 'user',
        fullName: '',
        email: '',
        phone: '',
        birthDay: CurrentDate(),
        gender: true,
        userName: '',
        password: '',
        confirmPassword: '',
        status: true,
    });

    const [errors, setErrors] = useState({
        fullName: '',
        email: '',
        phone: '',
        birthDay: '',
        userName: '',
        password: '',
        confirmPassword: '',
    });

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setFormData({
            ...formData,
            [name]: value,
        });
    };

    const handleSwitchChange = (event) => {
        setFormData({
            ...formData,
            status: event.target.checked,
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
            dispatch(CreateUserAction(formData));
            onClose();
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
    
    return (
        <>
            <Fragment>
                <Dialog
                    open={open}
                    onClose={onClose}
                    aria-labelledby="alert-dialog-title"
                    aria-describedby="alert-dialog-description"
                >
                    <DialogTitle id="alert-dialog-title">
                        Thêm người dùng mới
                    </DialogTitle>
                    <DialogContent>
                        <FormControl fullWidth margin="dense">
                            <InputLabel>Loại người dùng</InputLabel>
                            <Select
                                name="userTypeName"
                                value={formData.userTypeName}
                                onChange={handleInputChange}
                            >
                                {userTypeList.map((item, index) => (
                                    <MenuItem key={index} value={item.name}>{item.name}</MenuItem>
                                ))
                                }
                            </Select>
                        </FormControl>
                        <TextField
                            margin="dense"
                            name="fullName"
                            label="Họ tên"
                            type="text"
                            fullWidth
                            value={formData.fullName}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.fullName}
                            helperText={errors.fullName}
                        />
                        <TextField
                            margin="dense"
                            name="email"
                            label="Email"
                            type="email"
                            fullWidth
                            value={formData.email}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.email}
                            helperText={errors.email}
                        />
                        <TextField
                            margin="dense"
                            name="phone"
                            label="Số điện thoại"
                            type="text"
                            fullWidth
                            value={formData.phone}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.phone}
                            helperText={errors.phone}
                        />
                        <TextField
                            margin="dense"
                            name="birthDay"
                            label="Ngày sinh"
                            type="date"
                            fullWidth
                            InputLabelProps={{
                                shrink: true,
                            }}
                            value={formData.birthDay}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.birthDay}
                            helperText={errors.birthDay}
                        />
                        <FormControl fullWidth margin="dense">
                            <InputLabel>Giới tính</InputLabel>
                            <Select
                                name="gender"
                                value={formData.gender}
                                onChange={handleInputChange}
                            >
                                <MenuItem value={true}>Nam</MenuItem>
                                <MenuItem value={false}>Nữ</MenuItem>
                            </Select>
                        </FormControl>
                        <TextField
                            margin="dense"
                            name="userName"
                            label="Tài khoản"
                            type="text"
                            fullWidth
                            value={formData.userName}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.userName}
                            helperText={errors.userName}
                        />
                        <TextField
                            margin="dense"
                            name="password"
                            label="Mật khẩu"
                            type="text"
                            fullWidth
                            value={formData.password}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.password}
                            helperText={errors.password}
                        />
                        <TextField
                            margin="dense"
                            name="confirmPassword"
                            label="Nhập lại mật khẩu"
                            type="text"
                            fullWidth
                            value={formData.confirmPassword}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.confirmPassword}
                            helperText={errors.confirmPassword}
                        />
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={onClose}>Cancel</Button>
                        <Button onClick={handleSubmit} autoFocus>
                            Thêm
                        </Button>
                    </DialogActions>
                </Dialog>
            </Fragment>
        </>
    );
}

export default UserDialog;