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

const TheaterDialog = ({ open, onClose, row, isEditing }) => {
    const dispatch = useDispatch();
    const [formData, setFormData] = useState({
        name: '',
        address: '',
        image: '',
        phone: '',
        status: false,
    });

    const [errors, setErrors] = useState({
        name: '',
        address: '',
        image: '',
        phone: '',
    });


    useEffect(() => {
        if (row && open) {
            setFormData({
                id: row.id,
                name: row.name,
                address: row.address,
                image: row.image,
                phone: row.phone,
                status: row.status,
            });
        } else {
            setFormData({
                name: '',
                address: '',
                image: '',
                phone: '',
                status: false,
            });
        }
    }, [row]);

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
            if (isEditing) {
                dispatch(UpdateTheaterAction(formData));
            } else {
                dispatch(CreateTheaterAction(formData));
            }
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
                        {isEditing ? "Edit Theater" : "Create Theater"}
                    </DialogTitle>
                    <DialogContent>
                        <TextField
                            margin="dense"
                            name="name"
                            label="Name"
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
                            label="Address"
                            type="text"
                            fullWidth
                            value={formData.address}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.address}
                            helperText={errors.address}
                        />
                        <TextField
                            margin="dense"
                            name="image"
                            label="Image"
                            type="text"
                            fullWidth
                            value={formData.image}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.image}
                            helperText={errors.image}
                        />
                        <label for="image">Image:</label>
                        <input type="file" id="image" name="image" accept="image/png, image/jpeg" />
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
                            label="Status"
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
                        <Button onClick={onClose}>Cancel</Button>
                        <Button onClick={handleSubmit} autoFocus>
                            Save
                        </Button>
                    </DialogActions>
                </Dialog>
            </Fragment>
        </>
    );
}

export default TheaterDialog;