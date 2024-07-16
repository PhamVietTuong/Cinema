import React, { useState, useEffect } from 'react';
import moment from 'moment';
import { Box, Button, Typography, Avatar, IconButton, Menu, MenuItem, FormControl, InputLabel, Select, Grid, Tabs, Tab, Dialog, DialogTitle, DialogContent, TextField, DialogActions, RadioGroup, FormControlLabel, Radio, FormLabel } from '@mui/material';
import EditIcon from '@mui/icons-material/Edit';
import AddIcon from '@mui/icons-material/Add';
import './ShowTime.css';
import { ArrowBackIosNew, ArrowDropDown, ArrowForwardIos } from '@mui/icons-material';
import { useDispatch, useSelector } from 'react-redux';
import { GetTheaterRoomListAction, MovieListAdminAction, UpdateShowTimeRoomAction } from '../../../Redux/Actions/CinemasAction';
import { ProjectionForm } from '../../../Enum/ProjectionForm';
import Swal from 'sweetalert2';

const generateWeek = (offset = 0) => {
    const startOfWeek = moment().startOf('isoWeek').add(offset, 'weeks');
    return Array.from({ length: 7 }).map((_, i) => ({
        name: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'][i],
        date: startOfWeek.clone().add(i, 'days').format('YYYY-MM-DD'),
    }));
};

const ShowTime = () => {
    const period = 60
    const dispatch = useDispatch();
    const { listRoomofTheater, movieList } = useSelector((state) => state.CinemasReducer);

    const [timeSelected, setTimeSelected] = useState([]);
    const [weekOffset, setWeekOffset] = useState(0);
    const [anchorEl, setAnchorEl] = useState(null);
    const [selectedTheater, setSelectedTheater] = useState('');
    const [selectedRoom, setSelectedRoom] = useState(0);
    const [selectedRoomData, setSelectedRoomData] = useState(null);
    const [week, setWeek] = useState(generateWeek());
    const [schedules, setSchedules] = useState([]);
    const [openDialog, setOpenDialog] = useState(false);
    const [dialogData, setDialogData] = useState({ date: '', startTime: '', endTime: '', movieName: '', projectionForm: '' });
    const [selectedMovie, setSelectedMovie] = useState({});

    const formatHM = (date) => moment(date).format("HH:mm") 

    const open = Boolean(anchorEl);

    const handleClick = (event) => {
        setAnchorEl(event.currentTarget);
    };

    const handleClose = () => {
        setAnchorEl(null);
    };

    const handleSelect = (offset) => {
        setWeekOffset(offset);
        handleClose();
    };

    const handleTheaterChange = (event) => {
        const selectedTheaterId = event.target.value;
        setSelectedTheater(selectedTheaterId);
        const selectedTheaterData = listRoomofTheater.find(theater => theater.theaterId === selectedTheaterId);
        if (selectedTheaterData && selectedTheaterData.rooms.length > 0) {
            setSelectedRoom(0);
            setSelectedRoomData(selectedTheaterData.rooms[0]);
            setSchedules(selectedTheaterData.rooms[0].showTimeRooms)
        } else {
            setSelectedRoom(0);
            setSelectedRoomData(null);
            setSchedules([])
        }
    };

    const handleRoomChange = (event, newValue) => {
        setSelectedRoom(newValue);
        const roomData = rooms[newValue];
        setSelectedRoomData(roomData);
        setSchedules(roomData.showTimeRooms);
        setTimeSelected([]);
    };

    const selectedTheaterData = listRoomofTheater.find(theater => theater.theaterId === selectedTheater);
    const rooms = selectedTheaterData ? selectedTheaterData.rooms : [];

    useEffect(() => {
        if (selectedTheaterData && selectedTheaterData.rooms.length > 0) {
            setSelectedRoom(0);
            setSelectedRoomData(selectedTheaterData.rooms[0]);
        }
    }, [selectedTheater]);

    useEffect(() => {
        setWeek(generateWeek(weekOffset));
    }, [weekOffset]);

    const getTimeList = (startTime, endTime, period) => {
        const timeList = [];
        let current = moment(startTime, 'HH:mm');
        const end = moment(endTime, 'HH:mm');

        while (current.isBefore(end)) {
            const start = current.format('HH:mm');
            current.add(period, 'minutes');
            const end = current.format('HH:mm');
            timeList.push({ startTime: start, endTime: end });
        }

        return timeList;
    };

    const timeList = getTimeList('08:00', '24:00', period);

    const isSelectTime = (item) => {
        return timeSelected.some(
            (el) => moment(el.date).isSame(item.date, 'day') && el.startTime === item.startTime
        );
    };

    const getEventByDate = (date) => {
        return schedules.filter((e) => moment(date).isSame(e.startTime, 'day'));
    };

    const getEventStyle = (item) => {
        const dayStart = moment(item.startTime).startOf('day').add(8, 'hours');
        const startTimeMinutes = moment(item.startTime).diff(dayStart, 'minutes');
        const endTimeMinutes = moment(item.endTime).diff(dayStart, 'minutes');

        const periodHeight = 130;

        const top = (startTimeMinutes / period) * periodHeight;
        const height = ((endTimeMinutes - startTimeMinutes) / period) * periodHeight;

        return { top: `${top}px`, height: `${height}px` };
    };

    const selectTimeInTable = (item) => {
        if (!selectedTheater || moment(item.date).isBefore(moment(), 'day')) {
            return;
        }

        const a = timeSelected.findIndex(
            (el) => moment(el.date).isSame(item.date, 'day') && el.startTime === item.startTime
        );
        if (a !== -1) {
            const earliestStart = timeSelected.reduce((earliest, current) =>
                moment(current.startTime, 'HH:mm').isBefore(moment(earliest.startTime, 'HH:mm')) ? current : earliest
            ).startTime;

            const latestEnd = timeSelected.reduce((latest, current) =>
                moment(current.endTime, 'HH:mm').isAfter(moment(latest.endTime, 'HH:mm')) ? current : latest
            ).endTime;

            onClickCell(item.date, earliestStart, latestEnd);
        } else {
            const b = timeSelected.findIndex(
                (el) => moment(el.date).isSame(item.date, 'day') &&
                    (el.startTime === item.endTime || el.endTime === item.startTime)
            );
            if (b === -1 && timeSelected.length !== 0) {
                setTimeSelected([item]);
            } else {
                setTimeSelected([...timeSelected, item]);
            }
        }
    };

    const onClickEdit = (date, startTime, endTime) => {
        const timetable = getTimetable(date, startTime, endTime);
        if (timetable) {
            const formattedStartTime = moment(timetable.startTime).format('HH:mm');
            setDialogData({
                date,
                startTime: formattedStartTime,
                movieId: timetable.movieId,
                projectionForm: timetable.projectionForm,
                roomId: timetable.roomId,
                showTimeId: timetable.showTimeId,
            });
            setOpenDialog(true);
        } else {
            console.log('Không tìm thấy thời gian chiếu để sửa đổi.');
        }
    };

    const onClickCell = (date, startTime, endTime) => {
        setDialogData({ date, startTime, endTime, movieId: '', projectionForm: '' });
        setOpenDialog(true);
    };

    const handleDialogClose = () => {
        setOpenDialog(false);
        setDialogData({});
    };

    const handleDialogSave = () => {
        const infoMovie = movieList.find(movie => movie.id === dialogData.movieId)
        const projectionForm = dialogData.projectionForm === ProjectionForm.Time2D ? ProjectionForm.Time2D : ProjectionForm.Time3D;
        const movieDuration = projectionForm === ProjectionForm.Time2D ? infoMovie.time2D : infoMovie.time3D;
        const startTimeMoment = moment(dialogData.date + ' ' + dialogData.startTime, 'YYYY-MM-DD HH:mm');
        const endTimeMoment = startTimeMoment.clone().add(movieDuration + 20, 'minutes');

        const hasConflict = schedules.some((schedule) => {
            const existingStartTime = moment(schedule.startTime);
            const existingEndTime = moment(schedule.endTime);
            
            if (
                schedule.showTimeId !== dialogData.showTimeId &&
                (
                    startTimeMoment.isBetween(existingStartTime, existingEndTime, null, '()') ||
                    endTimeMoment.isBetween(existingStartTime, existingEndTime, null, '()') ||
                    existingStartTime.isBetween(startTimeMoment, endTimeMoment, null, '()') ||
                    existingEndTime.isBetween(startTimeMoment, endTimeMoment, null, '()')
                )
            ) {
                return true;
            }

            return false; 
        });

        if (hasConflict) {
            Swal.fire({
                title: "Thời gian chiếu đã chọn trùng với thời gian chiếu hiện có trong phòng.",
                padding: "15px",
                width: "500px",
                customClass: {
                    confirmButton: 'custom-ok-button'
                },
                showCancelButton: false,
            })
            setTimeSelected([])
            setSelectedMovie({})
            handleDialogClose();
            return;
        }

        const dialogInfo = {
            showTimeId: dialogData.showTimeId,
            movieId: dialogData.movieId,
            projectionForm: projectionForm,
            startTime: startTimeMoment.format('YYYY-MM-DDTHH:mm:ss'),
            endTime: endTimeMoment.format('YYYY-MM-DDTHH:mm:ss'),
            roomId: selectedRoomData.id,
            movieName: infoMovie.name
        };
        dispatch(UpdateShowTimeRoomAction(dialogInfo));

   setSchedules(prevSchedules => {
        const updatedSchedules = [...prevSchedules];
        const existingScheduleIndex = updatedSchedules.findIndex(
            (schedule) =>
                schedule.roomId === dialogInfo.roomId &&
                schedule.showTimeId === dialogInfo.showTimeId
        );

        if (existingScheduleIndex !== -1) {
            updatedSchedules[existingScheduleIndex] = dialogInfo;
        } else {
            updatedSchedules.push(dialogInfo);
        }
        
        return updatedSchedules;
    });
        setTimeSelected([])
        setSelectedMovie({})
        handleDialogClose();
    };

    const handleMovieChange = (e) => {
        const movieId = e.target.value;
        const selectedMovie = movieList.find(movie => movie.id === movieId);
        setSelectedMovie(selectedMovie);
        setDialogData({
            ...dialogData,
            movieId: movieId,
            projectionForm: selectedMovie.time2D !== -1 ? ProjectionForm.Time2D : selectedMovie.time3D !== -1 ? ProjectionForm.Time3D : '',
        });
    };

    const handleProjectionFormChange = (event) => {
        setDialogData({ ...dialogData, projectionForm: Number(event.target.value) });
    };

    const getTimetable = (date, startTime, endTime) => {
        return schedules.find(
            (e) => moment(e.startTime).isSame(date, 'day') && e.startTime === startTime && e.endTime === endTime
        );
    };

    useEffect(() => {
        dispatch(GetTheaterRoomListAction());
        dispatch(MovieListAdminAction());
    }, [dispatch]);

    return (
        <Box sx={{ overflow: 'hidden'}}>
            <Grid container spacing={2}>
                <Grid item xs={6}>
                    <FormControl fullWidth margin="dense">
                        <InputLabel id="theater-select-label">Chi nhánh</InputLabel>
                        <Select
                            labelId="theater-select-label"
                            id="theater-select"
                            name="theaterId"
                            label="Chi nhánh"
                            value={selectedTheater}
                            onChange={handleTheaterChange}
                        >
                            {listRoomofTheater.map((theater) => (
                                <MenuItem key={theater.theaterId} value={theater.theaterId}>
                                    {theater.theaterName}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>
                </Grid>
            </Grid>

            {selectedTheater && (
                <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
                    <Tabs
                        value={selectedRoom}
                        onChange={handleRoomChange}
                        aria-label="room tabs"
                        textColor="inherit"
                        indicatorColor="none"
                        sx={{
                            '& .MuiTab-root': {
                                textTransform: 'none',
                                alignItems: 'flex-start',
                                justifyContent: 'flex-start',
                                minHeight: '48px',
                                height: '48px',
                                color: '#1e2226', 
                                backgroundColor: '#ebf0f4', 
                                '&:hover': {
                                    backgroundColor: '#d9e2ec',
                                },
                                '&.Mui-selected': {
                                    borderBottom: '2px solid #3b44d1',
                                    color: '#3b44d1', 
                                    backgroundColor: '#fff',
                                }
                            },
                            '& .MuiTabs-indicator': {
                                display: 'none'
                            }
                        }}
                    >
                        {rooms.map((room, index) => (
                            <Tab
                                key={room.id}
                                label={`Rạp ${room.name}`}
                            />
                        ))}
                    </Tabs>
                </Box>
            )}

            <Box display="flex" justifyContent="space-between" alignItems="center">
                <IconButton onClick={() => setWeekOffset(weekOffset - 1)}>
                    <ArrowBackIosNew fontSize="small" />
                </IconButton>
                <Box display="flex" alignItems="center">
                    <Typography onClick={handleClick} style={{ cursor: 'pointer' }}>
                        <Box display="inline-flex" alignItems="center">
                            Tuần {weekOffset === 0 ? 'hiện tại' : `${weekOffset}`}
                            <ArrowDropDown />
                        </Box>
                    </Typography>
                    <Menu
                        anchorEl={anchorEl}
                        open={open}
                        onClose={handleClose}
                        MenuListProps={{
                            'aria-labelledby': 'basic-button',
                        }}
                    >
                        {[...Array(4)].map((_, index) => (
                            <MenuItem key={index} onClick={() => handleSelect(index)}>
                                Tuần {index === 0 ? 'hiện tại' : `số ${index}`}
                            </MenuItem>
                        ))}
                    </Menu>
                </Box>
                <IconButton onClick={() => setWeekOffset(weekOffset + 1)}>
                    <ArrowForwardIos fontSize="small" />
                </IconButton>
            </Box>
            <Box display="flex">
                <Box
                    className="schedule"
                    sx={{
                        minWidth: 110,
                        height: 70,
                        textAlign: 'center',
                        justifyContent: 'center',
                        display: 'flex',
                        alignItems: 'center',
                        border: '1px solid gray'
                    }}>
                    <Typography variant="body2">LỊCH CHIẾU</Typography>
                </Box>
                {week.map((day) => (
                    <Box
                        key={day.date}
                        className={`schedule ${moment(day.date).isSame(new Date(), 'day') ? 'current-date' : ''}`}
                        sx={{
                            flex: 1,
                            height: 70,
                            textAlign: 'center',
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                            justifyContent: 'center',
                            border: '1px solid gray'
                        }}>
                        <Typography variant="body2">{day.name}</Typography>
                        <Typography variant="body2" color="#fff">{moment(day.date).format('DD/MM/YYYY')}</Typography>
                    </Box>
                ))}
            </Box>

            <Box display="flex" sx={{overflow: 'hidden'}}>
                <Box className="time-slots" sx={{ minWidth: 110, borderRight: '1px solid #ccc' }}>
                    {timeList.map((item, index) => (
                        <Box key={index} className="time-slot" sx={{ height: 130, borderBottom: '1px solid #ccc', textAlign: 'center', fontSize: 12 }}>
                            {item.startTime} - {item.endTime}
                        </Box>
                    ))}
                </Box>
                {week.map((day) => (
                    <Box key={day.date} sx={{ flex: 1, borderLeft: '1px solid #ccc', position: 'relative' }}>
                        {timeList.map((item, index) => (
                            <Box key={index} sx={{ height: 130, borderBottom: '1px solid #ccc' }} className={isSelectTime({ startTime: item.startTime, date: day.date }) ? 'select' : ''}>
                                <Button onClick={() => selectTimeInTable({ startTime: item.startTime, endTime: item.endTime, date: day.date })} sx={{ height: '100%', width: '100%' }} />
                            </Box>
                        ))}
                        {getEventByDate(day.date).map((item) => (
                            <Box 
                                key={item.id} 
                                sx={{ 
                                    ...getEventStyle(item), 
                                    position: 'absolute', 
                                    width: '100%', 
                                    backgroundColor: '#007bff', 
                                    color: '#fff', 
                                    borderRadius: 1, 
                                    px: 2, 
                                    py: 1,
                                    overflow: 'auto'
                                }}>
                                <Box>
                                    <Typography variant="body1" sx={{ fontSize: 14 }}>
                                        {formatHM(item.startTime)} - {formatHM(item.endTime)}
                                    </Typography>
                                    <Typography variant="body2" sx={{ fontSize: 14 }}>
                                        {`${item.movieName} (${item.projectionForm === ProjectionForm.Time2D ? "2D" : "3D"})`}
                                    </Typography>
                                    <Button 
                                        onClick={() => onClickEdit(day.date, item.startTime, item.endTime)} 
                                        sx={{
                                            position: 'absolute',
                                            top: 4,
                                            right: 4,
                                            minWidth: 24,
                                            height: 24,
                                            color: '#1e2226'
                                        }}  
                                        disabled={moment(day.date).isBefore(moment(), 'day')}
                                    >
                                        <EditIcon sx={{ width: '100%', height: '100%' }} />
                                    </Button>
                                </Box>
                            </Box>
                        ))}
                    </Box>
                ))}
            </Box>
            <Dialog open={openDialog} onClose={handleDialogClose} maxWidth="sm" fullWidth>
                <DialogTitle>{dialogData.movieId ? 'Chỉnh Sửa Giờ Chiếu' : 'Thêm Giờ Chiếu'}</DialogTitle>
                <DialogContent>
                    <FormControl fullWidth margin="dense">
                        <InputLabel>Tên Phim</InputLabel>
                        <Select
                            labelId="movie-name-label"
                            id="movie-name-select"
                            label="Tên phim"
                            value={dialogData.movieId}
                            onChange={handleMovieChange}
                            fullWidth
                        >
                            {movieList.filter(x => x.status).map((movie) => (
                                <MenuItem key={movie.id} value={movie.id}>
                                    {movie.name}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>
                    <TextField
                        margin="dense"
                        label="Giờ Bắt Đầu"
                        type="time"
                        fullWidth
                        value={dialogData.startTime}
                        onChange={(e) => setDialogData({ ...dialogData, startTime: e.target.value })}
                        disabled={!dialogData.movieId}
                    />
                    {selectedMovie && (
                        <Box sx={{ display: 'flex', flexDirection: 'row', alignItems: 'center', gap: 2 }}>
                            <FormControl component="fieldset" margin="dense">
                                <FormLabel component="legend">Hình Thức Chiếu</FormLabel>
                                <RadioGroup row value={dialogData.projectionForm} onChange={handleProjectionFormChange}>
                                    {selectedMovie.time2D !== -1 && (
                                        <FormControlLabel value={ProjectionForm.Time2D} control={<Radio />} label="2D" />
                                    )}
                                    {selectedMovie.time3D !== -1 && (
                                        <FormControlLabel value={ProjectionForm.Time3D} control={<Radio />} label="3D" />
                                    )}
                                </RadioGroup>
                            </FormControl>
                        </Box>
                    )}
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleDialogClose} color="primary">
                        Hủy
                    </Button>
                    <Button onClick={handleDialogSave} color="primary" disabled={!dialogData.movieId}>
                        Lưu
                    </Button>
                </DialogActions>
            </Dialog>
        </Box>
    );
};

export default ShowTime;
