import { Button, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, FormControlLabel, Switch, TextField } from "@mui/material";
import { Fragment, useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { CreateAgeRestrictionAction, UpdateAgeRestrictionAction } from "../../../Redux/Actions/CinemasAction";
import * as yup from 'yup';

const schema = yup.object().shape({
    name: yup.string().required('Vui lòng nhập thông tin!'),
    description: yup.string().required('Vui lòng nhập thông tin!'),
    abbreviation: yup.string().required('Vui lòng nhập thông tin!'),
});

const AgeRestrictionDialog = ({ open, onClose, row, isEditing }) => {
    const dispatch = useDispatch();
    const [formData, setFormData] = useState({
        name: '',
        description: '',
        abbreviation: '',
        status: true,
    });

    const [errors, setErrors] = useState({
        name: '',
        description: '',
        abbreviation: '',
    });


    useEffect(() => {
        if (row && open) {
            setFormData({
                id: row.id,
                name: row.name,
                description: row.description,
                abbreviation: row.abbreviation,
                status: row.status,
            });
        } else {
            setFormData({
                name: '',
                description: '',
                abbreviation: '',
                status: true,
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
                dispatch(UpdateAgeRestrictionAction(formData));
            } else {
                dispatch(CreateAgeRestrictionAction(formData));
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
                        {isEditing ? "Sửa giới hạn độ tuổi" : "Thêm giới hạn độ tuổi"}
                    </DialogTitle>
                    <DialogContent>
                        <TextField
                            margin="dense"
                            name="name"
                            label="Tên ký hiệu"
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
                            name="description"
                            label="Mô tả"
                            type="text"
                            fullWidth
                            value={formData.description}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.description}
                            helperText={errors.description}
                        />
                        <TextField
                            margin="dense"
                            name="abbreviation"
                            label="Viết tắt"
                            type="text"
                            fullWidth
                            value={formData.abbreviation}
                            onChange={handleInputChange}
                            onBlur={(event) => validateField(event.target.name, event.target.value)}
                            error={!!errors.abbreviation}
                            helperText={errors.abbreviation}
                        />
                        {/* <FormControlLabel
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
                        /> */}
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={onClose}>Hủy</Button>
                        <Button onClick={handleSubmit} autoFocus>
                            Lưu
                        </Button>
                    </DialogActions>
                </Dialog>
            </Fragment>
        </>
    );
}

export default AgeRestrictionDialog;