import { Button, FormControl, FormHelperText, OutlinedInput } from '@mui/material';
import './ForgetPassword.css'
import { useState } from 'react';

import * as yup from 'yup';
import { ForgetPasswordAction } from '../../../Redux/Actions/UsersAction';
import { useDispatch } from 'react-redux';
import { useNavigate } from 'react-router-dom';

const schema = yup.object().shape({
    email: yup.string().email("Email không hợp lệ").required('Vui lòng nhập email'),
});

const ForgetPassword = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const [form, setForm] = useState({
        email: '',
    });
    const [errors, setErrors] = useState({
        email: '',
    });

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setForm({
            ...form,
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

    const handleChangePassword = async () => {
        try {
            await schema.validate(form, { abortEarly: false });
            dispatch(ForgetPasswordAction(form, navigate));
        } catch (validationErrors) {
            const newErrors = {};
            validationErrors.inner.forEach((error) => {
                newErrors[error.path] = error.message;
            });
            setErrors(newErrors);
        }
    }

    return (
        <>
            <section className="forget-password update-pass ht">
                <div className="container">
                    <div className="update-pass-wr txt-center mg-auto sec-heading">
                        <h2 className="heading">QUÊN MẬT KHẨU</h2>
                        <p className="desc">
                            Nhập địa chỉ email của bạn và chúng tôi sẽ gửi cho bạn hướng dẫn để tạo
                            mật khẩu mới
                        </p>
                        <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="changePasswordFormControl">
                            <OutlinedInput
                                className='changePasswordOutlinedInput'
                                name="email"
                                placeholder="Email"
                                onChange={handleInputChange}
                                onBlur={(event) => validateField(event.target.name, event.target.value)}
                            />
                            {!!errors.email && (
                                <FormHelperText>{errors.email}</FormHelperText>
                            )}
                        </FormControl>

                        <Button class="btn btn--pri changePasswordButton" onClick={handleChangePassword}>
                            GỬI MÃ XÁC MINH
                        </Button>
                    </div>
                </div>
            </section>
        </>
    );
}

export default ForgetPassword;