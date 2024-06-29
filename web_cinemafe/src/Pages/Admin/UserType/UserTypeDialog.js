import { Button, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, FormControlLabel, Switch, TextField } from "@mui/material";
import { Fragment, useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { CreateUserTypeAction, UpdateUserTypeAction } from "../../../Redux/Actions/CinemasAction";
import * as yup from 'yup';

const schema = yup.object().shape({
    name: yup.string().required('Name is required'),
});

const UserTypeDialog = ({ open, onClose, row, isEditing }) => {
    const dispatch = useDispatch();
    const [formData, setFormData] = useState({
        name: '',
        status: false,
    });

    const [errors, setErrors] = useState({
        name: '',
    });


    useEffect(() => {
        if (row && open) {
            setFormData({
                id: row.id,
                name: row.name,
                status: row.status,
            });
        } else {
            setFormData({
                name: '',
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
                dispatch(UpdateUserTypeAction(formData));
            } else {
                dispatch(CreateUserTypeAction(formData));
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
                        {isEditing ? "Edit User Type" : "Create User Type"}
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

export default UserTypeDialog;