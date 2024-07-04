import { Button, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, FormControlLabel, Switch, TextField } from "@mui/material";
import { Fragment, useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { CreateTheaterAction, UpdateTheaterAction } from "../../../Redux/Actions/CinemasAction";
import * as yup from 'yup';

const schema = yup.object().shape({
    name: yup.string().required('Name is required'),
    address: yup.string().required('Address is required'),
    image: yup.string().required('Image is required'),
    phone: yup.string().required('Phone is required'),
});

const TheaterDialog = ({ open, onClose}) => {
    const dispatch = useDispatch();
    const [formData, setFormData] = useState({
        name: '',
        address: '',
        image: null,
        phone: '',
        status: false,
    });

    const [errors, setErrors] = useState({
        name: '',
        address: '',
        image: '',
        phone: '',
    });

    const [imagePreviewUrl, setImagePreviewUrl] = useState(null);

    useEffect(() => {
            setFormData({
                name: '',
                address: '',
                image: null,
                phone: '',
                status: false,
            });
        setImagePreviewUrl(null);
    }, []);

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setFormData({
            ...formData,
            [name]: value,
        });
    };

    const handleFileChange = (event) => {
        const file = event.target.files[0];
        setFormData({
            ...formData,
            file: file,
            image: file.name,
        });
        validateField('image', file.name);
        const reader = new FileReader();
        reader.onloadend = () => {
            setImagePreviewUrl(reader.result);
        };
        if (file) {
            reader.readAsDataURL(file);
        }
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
            const formDataToSubmit = new FormData();
            for (const key in formData) {
                formDataToSubmit.append(key, formData[key]);
            }
            console.log(formData);

            dispatch(CreateTheaterAction(formDataToSubmit));
            onClose();
        } catch (error) {
            console.error('Validation Error:', error.errors);
            error.inner.forEach(err => {
                setErrors(prevErrors => ({
                    ...prevErrors,
                    [err.path]: err.message,
                }));
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
                        Create Theater
                    </DialogTitle>
                    <DialogContent>
                        <TextField
                            margin="dense"
                            name="name"
                            label="Tên"
                            type="text"
                            fullWidth
                            value={formData.name}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.name}
                            helperText={errors.name}
                        />
                        <TextField
                            margin="dense"
                            name="address"
                            label="Địa chỉ"
                            type="text"
                            fullWidth
                            value={formData.address}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.address}
                            helperText={errors.address}
                        />
                        {imagePreviewUrl && <img src={imagePreviewUrl} alt="Image Preview" style={{ width: '100%', marginTop: '10px' }} />}
                        <label htmlFor="image">Image:</label>
                        <input
                            type="file"
                            id="image"
                            name="image"
                            accept="image/png, image/jpeg"
                            onChange={handleFileChange}
                        />
                        {errors.image && <p style={{ color: 'red' }}>{errors.image}</p>}
                        <TextField
                            margin="dense"
                            name="phone"
                            label="Phone"
                            type="text"
                            fullWidth
                            value={formData.phone}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.phone}
                            helperText={errors.phone}
                        />
                        <FormControlLabel
                            label="Trạng thái"
                            labelPlacement="start"
                            control={
                                <Switch
                                    checked={formData.status}
                                    onChange={handleSwitchChange}
                                    name="status"
                                    color="primary"
                                />
                            }
                        />
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={onClose}>Hủy bỏ</Button>
                        <Button onClick={handleSubmit} autoFocus>
                            Lưu
                        </Button>
                    </DialogActions>
                </Dialog>
            </Fragment>
        </>
    );
}

export default TheaterDialog;