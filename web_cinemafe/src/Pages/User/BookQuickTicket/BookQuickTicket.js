import { Box, Button, FormControl, InputLabel, MenuItem, Select } from '@mui/material';
import './BookQuickTicket.css'
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { ListMovieByTheaterIdAction, ListShowTimeByMovieIdAction } from '../../../Redux/Actions/CinemasAction';
import moment from 'moment';
import 'moment/locale/vi';
import { ShowTimeType } from '../../../Enum/ShowTimeType';
import { Link, useNavigate } from 'react-router-dom';

const generateDates = (numDays) => {
    const dates = [];
    for (let i = 0; i < numDays; i++) {
        dates.push(moment().add(i, 'days'));
    }
    return dates;
};

const dates = generateDates(3);

const BookQuickTicket = (props) => {
    const {
        isLoggedIn,
    } = useSelector((state) => state.UserReducer);
    const navigate = useNavigate();

    const [theater, setTheater] = useState("");
    const [theaterId, setTheaterId] = useState("");
    const [selectedheaterName, setSelectedheaterName] = useState("");

    const [Movie, setMovie] = useState("");
    const [movieId, setMovieId] = useState("");
    const [projectionForm, setProjectionForm] = useState("");

    const [date, setDate] = useState("");
    const [activeDateIndex, setActiveDateIndex] = useState(0);
    const [dateMovie, setdateMovie] = useState("");

    const [showTime, setShowTime] = useState("");
    const [showTimeId, setshowTimeId] = useState("");
    const [roomId, setRoomId] = useState("");
    const [selectedShowTime, setSelectedShowTime] = useState("");

    const [route, setRoute] = useState("/");
    const [routeState, setRouteState] = useState({});
    const dispatch = useDispatch();
    const { listMovieByTheaterIdBookQuickTicket, listShowTimeByMovieId } = useSelector((state) => state.CinemasReducer)

    const [screenWidth, setScreenWidth] = useState(window.innerWidth);

    useEffect(() => {
        if (theaterId) {
            dispatch(ListMovieByTheaterIdAction(theaterId))
        }
    }, [dispatch, theaterId]);

    useEffect(() => {
        if (movieId && projectionForm && dateMovie) {
            dispatch(ListShowTimeByMovieIdAction(movieId, dateMovie, projectionForm))
        }
    }, [dispatch, movieId, projectionForm, dateMovie]);

    const handleTheaterChange = (e) => {
        if (!e.target.value.includes('|')) {
            return
        }

        const [id, name] = e.target.value.split('|');
        setTheater(e.target.value);
        setTheaterId(id);
        setSelectedheaterName(name);

        setMovie("");
        setMovieId("");
        setProjectionForm("");

        setShowTime("");
        setshowTimeId("");
        setRoomId("");
        setSelectedShowTime("");
        setDate("");

        setRoute("/");
        setRouteState({});
    };

    const handleMovieChange = (e) => {
        if (!e.target.value.includes('|')) {
            return
        }
        const [id, projectionForm] = e.target.value.split('|');
        setMovie(e.target.value);
        setProjectionForm(projectionForm)
        setMovieId(id)
    };

    const handleDateChange = (e) => {
        if (!e.target.value.includes('|')) {
            return
        }
        const [date, index] = e.target.value.split('|');
        setDate(e.target.value)
        setActiveDateIndex(index);
        setdateMovie(date)
    };

    const handleShowTimeChange = (e) => {
        const [showTimeId, roomId, selectedShowTime] = e.target.value.split('|');
        setShowTime(e.target.value);
        setshowTimeId(showTimeId)
        setRoomId(roomId)
        setSelectedShowTime(selectedShowTime)
    };

    useEffect(() => {
        if (theaterId) {
            setRoute(`/book-tickets/${theaterId}`)
        }

        if (theaterId && movieId && projectionForm) {
            setRoute(`/movie/${movieId}/?id=${theaterId}&show_time=${showTimeId}&room=${roomId}`)
            setRouteState(
                {
                    projectionForm: Number(projectionForm),
                    selectedShowTime: selectedShowTime,
                    selectedheaterName: selectedheaterName,
                    activeDateIndex: activeDateIndex,
                }
            )
        }
    }, [theater, Movie, showTime, activeDateIndex]);

    const filteredShowTimes = listShowTimeByMovieId.filter(item => {
        const showTimeDate = moment(item.startTime);
        if (moment(dateMovie).isSame(moment(), 'day')) {
            return showTimeDate.isAfter(moment());
        }
        return true;
    });

    const handleLinkClick = () => (e) => {
        if (!isLoggedIn) {
            e.preventDefault();
            return navigate("/login");
        }
    };

    useEffect(() => {
        const handleResize = () => setScreenWidth(window.innerWidth);
        window.addEventListener('resize', handleResize);
        return () => window.removeEventListener('resize', handleResize);
    }, []);

    return (
        <>
            <div className="container">
                <div className="navigate-wrap">
                    <div className="heading">
                        <h1>Đặt vé nhanh</h1>
                    </div>
                    <div className="navigate-filter">
                        <FormControl fullWidth className='BQTFormControl'>
                            <InputLabel className='BQTInputLabel'>1. Chọn chi nhánh</InputLabel>
                            <Select
                                value={theater}
                                onChange={handleTheaterChange}
                                label="1. Chọn chi nhánh"
                                className={`${theaterId ? "isActive" : ""} BQTSelect`}
                            >
                                {
                                    props.theaterList.length !== 0 ?
                                        props.theaterList.length > 0 && props.theaterList.map((item) => (
                                            <MenuItem value={`${item.id}|${item.name}`} className='BQTMenuItem'>{item.name}</MenuItem>
                                        ))
                                        :
                                        (
                                            <MenuItem
                                                className='BQTMenuItem NotHasValue'
                                            >
                                                <div class="movies-rp-noti navigate-notfound">
                                                    <div class="dark-image">
                                                        <img src="/Images/movie-updating.png" alt="" />
                                                    </div>Chưa có chi nhánh</div>
                                            </MenuItem>
                                        )
                                }
                            </Select>
                        </FormControl>
                        {
                            (screenWidth > 390 || theater) && (
                                <FormControl fullWidth className={`${theaterId ? "" : "NotHasValue"}`}>
                                    <InputLabel className='BQTInputLabel'>2. Chọn phim</InputLabel>
                                    <Select
                                        value={Movie}
                                        label="2. Chọn phim"
                                        className={`${Movie ? "isActive" : ""} BQTSelect`}
                                        onChange={handleMovieChange}
                                    >
                                        {
                                            listMovieByTheaterIdBookQuickTicket.length !== 0 ?
                                                listMovieByTheaterIdBookQuickTicket.map((item) => (
                                                    <MenuItem
                                                        key={item.id}
                                                        value={`${item.id}|${item.projectionForm}`}
                                                        className='BQTMenuItem'
                                                    >
                                                        {item.name} {item.showTimeTypeName} {`(${item.ageRestrictionName})`}
                                                    </MenuItem>
                                                ))
                                                :
                                                (
                                                    <MenuItem
                                                        className='BQTMenuItem NotHasValue'
                                                    >
                                                        <div class="movies-rp-noti navigate-notfound">
                                                            <div class="dark-image">
                                                                <img src="/Images/movie-updating.png" alt="" />
                                                            </div>Chưa có phim</div>
                                                    </MenuItem >
                                                )
                                        }
                                    </Select>
                                </FormControl>
                            )
                        }
                        {
                            (screenWidth > 390 || Movie) && (<FormControl fullWidth className={`${Movie ? "" : "NotHasValue"}`}>
                                <InputLabel className='BQTInputLabel'>3. Chọn ngày</InputLabel>
                                <Select
                                    value={date}
                                    label="3. Chọn ngày"
                                    className={`${date ? "isActive" : ""} BQTSelect`}
                                    onChange={handleDateChange}
                                >
                                    {
                                        dates.length !== 0 ?
                                            dates.map((date, index) => (
                                                <MenuItem
                                                    key={moment(date).format("YYYY-MM-DDTHH:mm:ss")}
                                                    value={`${moment(date).format("YYYY-MM-DDTHH:mm:ss")}|${index}`}
                                                    className='BQTMenuItem'
                                                >
                                                    {moment(date).format("dddd").replace(/^\w/, (c) => c.toUpperCase()) + ', '} {moment(date).format("DD/MM")}
                                                </MenuItem>
                                            ))
                                            :
                                            (
                                                <MenuItem
                                                    className='BQTMenuItem NotHasValue'
                                                >
                                                    <div class="movies-rp-noti navigate-notfound">
                                                        <div class="dark-image">
                                                            <img src="/Images/movie-updating.png" alt="" />
                                                        </div>Chưa có ngày chiếu</div>
                                                </MenuItem>
                                            )
                                    }
                                </Select>
                            </FormControl>)}
                        {
                            (screenWidth > 390 || date) && (<FormControl fullWidth className={`${date ? "" : "NotHasValue"}`}>
                                <InputLabel className='BQTInputLabel'>4. Chọn suất</InputLabel>
                                <Select
                                    value={showTime}
                                    label="4. Chọn suất"
                                    className={`${showTimeId ? "isActive" : ""} BQTSelect`}
                                    onChange={handleShowTimeChange}
                                >
                                    {
                                        filteredShowTimes.length !== 0
                                            ?
                                            filteredShowTimes.map((item) => (
                                                <MenuItem
                                                    key={item.showTimeId}
                                                    value={`${item.showTimeId}|${item.roomId}|${moment(new Date(item.startTime)).format("HH:mm")}`}
                                                    className='BQTMenuItem'
                                                    onClick={handleLinkClick()}
                                                >
                                                    {moment(new Date(item.startTime)).format("HH:mm") + " - "} {item.showTimeType === ShowTimeType.Deluxe ? "Deluxe" : "Standard"}
                                                </MenuItem>
                                            ))
                                            :
                                            (
                                                <MenuItem
                                                    className='BQTMenuItem NotHasValue'
                                                >
                                                    <div class="movies-rp-noti navigate-notfound">
                                                        <div class="dark-image">
                                                            <img src="/Images/movie-updating.png" alt="" />
                                                        </div>Chưa có suất chiếu</div>
                                                </MenuItem>
                                            )
                                    }
                                </Select>
                            </FormControl>)}

                        <div className="navigate-filter-btn">
                            <Button variant="contained" className={`${theaterId ? "" : "preventClick"} btn btn--second`}>
                                <Link to={route} state={routeState}>
                                    Đặt ngay
                                </Link>
                            </Button>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}

export default BookQuickTicket;