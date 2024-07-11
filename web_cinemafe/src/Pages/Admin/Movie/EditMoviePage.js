import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from "react-redux";
import { DOMAIN } from "../../../Ustil/Settings/Config";
import { useNavigate, useParams } from "react-router-dom";
import { MovieByIdActionAdmin, GetAgeRestrictionListAction, GetMovieTypeListAction, GetTheaterRoomListAction, UpdateMovieAction } from "../../../Redux/Actions/CinemasAction";
import { TextField, Grid, Button, Box, FormControl, InputLabel, Select, MenuItem, FormHelperText, Typography, Radio, RadioGroup, FormControlLabel } from "@mui/material";
import moment from 'moment';
import HighlightedText from './HighlightedText';
import { format } from 'date-fns';
import { ProjectionForm } from '../../../Enum/ProjectionForm';
import Swal from 'sweetalert2';

const EditMoviePage = () => {
    const { id } = useParams();
    const dispatch = useDispatch();
    const { movie, ageRestrictionList, movieTypeList, listRoomofTheater } = useSelector((state) => state.CinemasReducer);
    const [errors, setErrors] = useState({});
    const [selectedMovieTypes, setSelectedMovieTypes] = useState([]);
    const [movieData, setMovieData] = useState({
        name: '',
        ageRestrictionId: "",
        image: 'movie.png',
        time2D: -1,
        time3D: -1,
        releaseDate: '',
        actor: '',
        director: '',
        description: '',
        languages: '',
        trailer: '',
        status: false,
        movieTypes: [],
        showTimeRooms: [],
    });
    const [newShowTime, setNewShowTime] = useState({
        theaterId: '',
        theaterName: '',
        roomId: '',
        roomName: '',
        startTime: '',
        endTime: '',
        projectionForm: ProjectionForm.Time2D,
    });
    const [availableRooms, setAvailableRooms] = useState([]);
    const [roomShowtimes, setRoomShowtimes] = useState([]);
    const navigate = useNavigate();

    const handleMovieTypesChange = (event) => {
        const value = event.target.value;
        setErrors((prevErrors) => ({ ...prevErrors, movieTypes: '' }));
        setSelectedMovieTypes(value);
        const res = movieTypeList.filter(element => value.includes(element.id));
        setMovieData((prevData) => ({ ...prevData, movieTypes: res }));
    };

    useEffect(() => {
        if (movie && (movie.id !== movieData.id)) {
            setMovieData(movie);
            setSelectedMovieTypes(movie.movieTypes?.map((movieType) => movieType.id) || []);
        }
    }, [movie, movieData.id]);

    const handleChange = (event) => {
        const { name, value } = event.target;
        setMovieData((prevData) => ({
            ...prevData,
            [name]: value,
        }));
    };

    const handleNewShowTimeChange = (event) => {
        const { name, value } = event.target;
        setNewShowTime((prevData) => ({
            ...prevData,
            [name]: value,
        }));

        if (name === 'theaterId') {
            const selectedTheater = listRoomofTheater.find(theater => theater.theaterId === value);
            if (selectedTheater) {
                setAvailableRooms(selectedTheater.rooms);
                setNewShowTime((prevData) => ({
                    ...prevData,
                    theaterName: selectedTheater.theaterName,
                    roomId: '',
                    roomName: ''
                }));
                setRoomShowtimes([]);
            }
        } else if (name === 'roomId') {
            const selectedRoom = availableRooms.find(room => room.id === value);
            if (selectedRoom) {
                setNewShowTime((prevData) => ({
                    ...prevData,
                    roomName: selectedRoom.name
                }));
                setRoomShowtimes(selectedRoom.showTimeRooms);
            }
        }
    };

    const handleProjectionFormChange = (event) => {
        setNewShowTime((prevData) => ({
            ...prevData,
            projectionForm: event.target.value,
        }));
    };

    const handleAddShowTime = () => {
        const room = availableRooms.find(room => room.id === newShowTime.roomId);
        if (room) {
            const newStart = moment(newShowTime.startTime);
            let duration = 0;
            if (newShowTime.projectionForm === ProjectionForm.Time2D) {
                duration = movieData.time2D + 20; 
            } else if (newShowTime.projectionForm === ProjectionForm.Time3D) {
                duration = movieData.time3D + 20; 
            }
            const newEnd = newStart.clone().add(duration, 'minutes');
            const newShowTimeWithEndTime = {
                ...newShowTime,
                endTime: newEnd.format('YYYY-MM-DDTHH:mm'),
            };

            const hasOverlap = room.showTimeRooms.some(showTime => {
                const existingStart = moment(showTime.startTime);
                const existingEnd = moment(showTime.endTime);
                return newStart.isBetween(existingStart, existingEnd, null, '[)') || newEnd.isBetween(existingStart, existingEnd, null, '(]');
            });

            if (hasOverlap) {
                Swal.fire({
                    title: "Thời gian chiếu đã chọn trùng với thời gian chiếu hiện có trong phòng.",
                    padding: "15px",
                    width: "500px",
                    customClass: {
                        confirmButton: 'custom-ok-button'
                    },
                    showCancelButton: false,
                })
                return;                
            }

            setMovieData((prevData) => ({
                ...prevData,
                showTimeRooms: [...prevData.showTimeRooms, newShowTimeWithEndTime],
            }));
            setNewShowTime({
                theaterId: '',
                theaterName: '',
                roomId: '',
                roomName: '',
                startTime: '',
                endTime: '',
                projectionForm: ProjectionForm.Time2D,
            });
        }
    };

    const getCurrentDateTime = () => {
        return moment().format('YYYY-MM-DDTHH:mm');
    };

    const handleSubmit = (event) => {
        event.preventDefault();
        dispatch(UpdateMovieAction(movieData, navigate));
    };

    useEffect(() => {
        dispatch(MovieByIdActionAdmin(id));
        dispatch(GetAgeRestrictionListAction());
        dispatch(GetMovieTypeListAction());
        dispatch(GetTheaterRoomListAction());
    }, [dispatch, id]);

    const returnStatusShowTime = (startTime, endTime) => {
        const now = moment();
        if (now.isBetween(moment(startTime), moment(endTime))) {
            return "Đang chiếu";
        } else if (now.isBefore(moment(startTime))) {
            return "Sắp chiếu";
        } else {
            return "Đã chiếu";
        }
    }

    useEffect(() => {
        console.log(movieData);
    }, [movieData]);
    return (
        <Box component="form" onSubmit={handleSubmit} sx={{ margin: 'auto', mt: 5 }}>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 2 }}>
                <Button onClick={() => { }} color="secondary">Hủy</Button>
                <Button type="submit" color="primary">Lưu</Button>
            </Box>
            <Grid container spacing={2} display={"flex"}>
                <Grid item sm={3} xs={12} sx={{ borderRadius: '4px', }}>
                    <img
                        src={(movie.image === "movie.png") ? "/Images/movie.png" : `${DOMAIN}/Images/${movie.image}`}
                        alt={movie.name}
                        style={{ width: '100%', height: '100%', objectFit: 'cover', borderRadius: '4px', }}
                    />
                </Grid>
                <Grid item sm={9} xs={12}>
                    <TextField
                        margin="dense"
                        name="name"
                        label="Tên phim"
                        type="text"
                        fullWidth
                        variant="outlined"
                        value={movieData.name}
                        onChange={handleChange}
                    />
                    <FormControl fullWidth margin="dense" error={!!errors.ageRestrictionId}>
                        <InputLabel id="dropdown-label" sx={{ fontSize: '18px' }}>Giới hạn độ tuổi</InputLabel>
                        <Select
                            name="ageRestrictionId"
                            labelId="dropdown-label"
                            id="dropdown"
                            label="Giới hạn độ tuổi"
                            value={movieData.ageRestrictionId}
                            onChange={handleChange}
                            sx={{ color: 'black', backgroundColor: 'white' }}
                        >
                            {ageRestrictionList.map((ageRestriction) => (
                                <MenuItem key={ageRestriction.id} value={ageRestriction.id}>
                                    {ageRestriction.name} - {ageRestriction.description}
                                </MenuItem>
                            ))}
                        </Select>
                        <FormHelperText>{errors.ageRestrictionId}</FormHelperText>
                    </FormControl>
                    <TextField
                        margin="dense"
                        name="time2D"
                        label="Thời gian 2D"
                        type="number"
                        fullWidth
                        variant="outlined"
                        value={movieData.time2D}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="time3D"
                        label="Thời gian 3D"
                        type="number"
                        fullWidth
                        variant="outlined"
                        value={movieData.time3D}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="actor"
                        label="Diễn viên"
                        type="text"
                        multiline
                        fullWidth
                        variant="outlined"
                        value={movieData.actor}
                        onChange={handleChange}
                    />
                    <TextField
                        rows={4}
                        margin="dense"
                        name="description"
                        label="Nội dung"
                        type="text"
                        fullWidth
                        multiline
                        variant="outlined"
                        value={movieData.description}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="languages"
                        label="Ngôn ngữ"
                        type="text"
                        fullWidth
                        variant="outlined"
                        value={movieData.languages}
                        onChange={handleChange}
                    />
                    <TextField
                        label="Ngày ra mắt"
                        name="releaseDate"
                        type="date"
                        value={movieData.releaseDate?.split("T")[0]}
                        onChange={handleChange}
                        fullWidth
                        margin="dense"
                        InputLabelProps={{ shrink: true }}
                        error={!!errors.releaseDate}
                        helperText={errors.releaseDate}
                    />
                    <FormControl fullWidth margin="dense" error={!!errors.movieTypes}>
                        <InputLabel id="movie-type-label">Thể loại phim</InputLabel>
                        <Select
                            labelId="movie-type-label"
                            id="movie-type-select"
                            label="Thể loại phim"
                            multiple
                            value={selectedMovieTypes}
                            onChange={handleMovieTypesChange}
                            renderValue={(selected) => {
                                const selectedMovieTypes = movieTypeList.filter((movieType) => selected.includes(movieType.id));
                                return selectedMovieTypes.map((movieType) => movieType.name).join(', ');
                            }}
                            sx={{ backgroundColor: 'white' }}
                        >
                            {movieTypeList.map((movieType) => (
                                <MenuItem key={movieType.id} value={movieType.id}>
                                    {movieType.name}
                                </MenuItem>
                            ))}
                        </Select>
                        <FormHelperText>{errors.movieTypes}</FormHelperText>
                    </FormControl>

                    <TextField
                        margin="dense"
                        name="director"
                        label="Đạo diễn"
                        type="text"
                        fullWidth
                        variant="outlined"
                        value={movieData.director}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="trailer"
                        label="Mã trailer"
                        type="text"
                        fullWidth
                        variant="outlined"
                        value={movieData.trailer}
                        onChange={handleChange}
                    />
                </Grid>
            </Grid>
            <Box sx={{ marginTop: 2 }}>
                <Typography variant="h6" sx={{ mb: 2 }}>Thêm xuất chiếu</Typography>
                <Grid container spacing={2}>
                    <Grid item xs={6}>
                        <FormControl fullWidth margin="dense">
                            <InputLabel id="theater-select-label">Rạp</InputLabel>
                            <Select
                                labelId="theater-select-label"
                                id="theater-select"
                                name="theaterId"
                                label="Rạp"
                                value={newShowTime.theaterId}
                                onChange={handleNewShowTimeChange}
                            >
                                {listRoomofTheater.map((theater) => (
                                    <MenuItem key={theater.theaterId} value={theater.theaterId}>
                                        {theater.theaterName}
                                    </MenuItem>
                                ))}
                            </Select>
                        </FormControl>
                    </Grid>
                    <Grid item xs={6}>
                        <FormControl fullWidth margin="dense">
                            <InputLabel id="room-select-label">Phòng</InputLabel>
                            <Select
                                labelId="room-select-label"
                                id="room-select"
                                name="roomId"
                                label="Phòng"
                                value={newShowTime.roomId}
                                onChange={handleNewShowTimeChange}
                                disabled={!newShowTime.theaterId}
                            >
                                {availableRooms.map((room) => (
                                    <MenuItem key={room.id} value={room.id}>
                                        {room.name}
                                    </MenuItem>
                                ))}
                            </Select>
                        </FormControl>
                    </Grid>
                    {roomShowtimes.length > 0 && (
                        <Grid item xs={12}>
                        <Box sx={{ mt: 2 }}>
                            <Typography variant="h6" gutterBottom>
                                Suất chiếu của phòng đã chọn
                            </Typography>
                            <Grid container spacing={2} sx={{ justifyContent: 'space-between', padding: 2 }}>
                                {roomShowtimes.map((showTime, index) => (
                                    <Grid key={index} item sx={{ display: "flex", mb: 2, position: 'relative' }} xs={6} xl={6}>
                                        <Box sx={{ mr: 1, width: '15px' }}>
                                            {index + 1}.
                                        </Box>
                                        <Box sx={{ display: "flex", flex: 1, border: "1px solid #000", padding: "10px", borderRadius: '4px' }}>
                                            <Box sx={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
                                                <Box>
                                                    <HighlightedText label="Giờ chiếu" text={`${moment(showTime.startTime).format("HH:mm")} - ${moment(showTime.endTime).format("HH:mm")} (${format(new Date(showTime.startTime), 'dd/MM/yyyy')})`} />
                                                    <HighlightedText label="Hình thức chiếu" text={showTime.projectionForm === ProjectionForm.Time2D ? "2D" : "3D"} />
                                                    <HighlightedText label="Trạng thái" text={returnStatusShowTime(showTime.startTime, showTime.endTime)} />
                                                </Box>
                                            </Box>
                                        </Box>
                                    </Grid>
                                ))}
                            </Grid>
                        </Box>
                        </Grid>
                    )}
                    <Grid item xs={6}>
                        <TextField
                            label="Giờ chiếu"
                            name="startTime"
                            type="datetime-local"
                            value={newShowTime.startTime}
                            onChange={handleNewShowTimeChange}
                            fullWidth
                            margin="dense"
                            InputLabelProps={{ shrink: true }}
                            inputProps={{ min: getCurrentDateTime() }}
                            disabled={!newShowTime.roomId}
                        />
                        <FormControl component="fieldset" margin="dense">
                            <RadioGroup
                                row
                                name="projectionForm"
                                value={newShowTime.projectionForm}
                                onChange={handleProjectionFormChange}
                            >
                                <FormControlLabel value={ProjectionForm.Time2D} control={<Radio />} label="2D" />
                                <FormControlLabel value={ProjectionForm.Time3D} control={<Radio />} label="3D" />
                            </RadioGroup>
                        </FormControl>
                    </Grid>
                    <Grid item xs={12}>
                        <Button variant="contained" color="primary" onClick={handleAddShowTime}>
                            Add Showtime
                        </Button>
                    </Grid>
                </Grid>
                <Grid container spacing={2} sx={{ justifyContent: 'space-between', padding: 2 }}>
                    {movieData?.showTimeRooms?.map((item, index) => (
                        <Grid key={index} item sx={{ display: "flex", mb: 2, position: 'relative' }} xs={12} xl={5.9}>
                            <Box sx={{ mr: 1, width: '15px' }}>
                                {index + 1}.
                            </Box>
                            <Box sx={{ display: "flex", flex: 1, border: "1px solid #000", padding: "10px", borderRadius: '4px' }}>
                                <Box sx={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
                                    <Box>
                                        <HighlightedText label="Rạp" text={item.theaterName} />
                                        <HighlightedText label="Phòng" text={item.roomName} />
                                        <HighlightedText label="Hình thức chiếu" text={item.projectionForm === ProjectionForm.Time2D ? "2D" : "3D"} />
                                        <HighlightedText label="Giờ chiếu" text={`${moment(item.startTime).format("HH:mm")} - ${moment(item.endTime).format("HH:mm")} (${format(new Date(item.startTime), 'dd/MM/yyyy')})`} />
                                        <HighlightedText label="Trạng thái" text={returnStatusShowTime(item.startTime, item.endTime)} />
                                    </Box>
                                </Box>
                            </Box>
                        </Grid>
                    ))}
                </Grid>
            </Box>
        </Box>
    );
};

export default EditMoviePage;
