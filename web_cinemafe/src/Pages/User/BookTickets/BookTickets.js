import './BookTickets.css'
import { Box, CircularProgress, Grid, Tab } from '@mui/material';
import { TabContext, TabList, TabPanel } from '@mui/lab';
import BookTicket from '../../../Components/Film/BookTicket';
import { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { useEffect } from 'react';
import { ShowTimeByTheaterIdAction, TheaterAction } from '../../../Redux/Actions/CinemasAction';
import { DOMAIN } from '../../../Ustil/Settings/Config';
import moment from 'moment';

const BookTickets = () => {
    let { id } = useParams();

    const dispatch = useDispatch();
    const [value, setValue] = useState('1');
    const { theaterDetail, listMovieByTheaterId } = useSelector((state) => state.CinemasReducer)
    const [loading, setLoading] = useState(true);

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    useEffect(() => {
        setLoading(true);
        const fetchData = async () => {
            await dispatch(TheaterAction(id));
            await dispatch(ShowTimeByTheaterIdAction(id));
            setLoading(false);
        };
        fetchData();
    }, [dispatch, id]);

    const isCurrentMovie = (movies) => {
        const currentTime = moment();
        const today = moment().startOf('day');
        const endDate = moment().add(2, 'days').endOf('day');

        return movies
            .filter(movie => moment(movie.releaseDate).isSameOrBefore(today))
            .map(movie => {
                const filteredSchedules = movie.schedules.filter(schedule =>
                    moment(schedule.date).isBetween(today, endDate, null, '[]')
                ).map(schedule => {
                    const filteredTheaters = schedule.theaters.map(theater => {
                        const filteredShowTimes = theater.showTimes.filter(showTime =>
                            moment(showTime.startTime).isSameOrAfter(currentTime)
                        );
                        return {
                            ...theater,
                            showTimes: filteredShowTimes
                        };
                    }).filter(theater => theater.showTimes.length > 0);

                    return {
                        ...schedule,
                        theaters: filteredTheaters
                    };
                }).filter(schedule => schedule.theaters.length > 0);

                return {
                    ...movie,
                    schedules: filteredSchedules
                };
            })
            .filter(movie => movie.schedules.length > 0);
    };

    const isUpcomingMovie = (movies) => {
        const today = moment().startOf('day');

        return movies
            .filter(movie => moment(movie.releaseDate).isAfter(today))
    };

    const isSpecialMovie = (movies) => {
        const today = moment().startOf('day');

        return movies.filter(movie => moment(movie.releaseDate).isAfter(today) && movie.isSpecial)
    }

    if (loading) {
        return (
            <Box sx={{ textAlign: 'center' }}>
                <CircularProgress />
            </Box>
        );
    }

    return (
        <>
            <div className="app-content">
                <section className="sec-hbooking">
                    <div className="hbooking ht custom-spacing">
                        <div className="container">
                            <div className="hbooking-new">
                                <div className="hbooking-left" data-aos="fade-up">
                                    <img src={`${DOMAIN}/Images/${theaterDetail?.image}`} alt={`${theaterDetail?.image}`}></img>
                                </div>
                                <div className="hbooking-right" data-aos="fade-up">
                                    <div className="address-box">
                                        <h4 className="sub-tittle txt-upper">{theaterDetail?.name}</h4>
                                        <a className="link" href="#">
                                            <span className="ic">
                                                <img src="/Images/ic-location.svg" alt="ic-location.svg" />
                                            </span>
                                            <span className="txt">
                                                {theaterDetail?.address}
                                            </span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section className="sec-movies">
                    <div className="movies sc-pd-b">
                        <div className="container">
                            <Box sx={{ width: '100%', typography: 'body1' }} className='BTSBox'>
                                <TabContext value={value} className='BTSTabContent'>
                                    <Box sx={{ borderBottom: 1, borderColor: 'divider' }} className='BTSTabContentBox'>
                                        <TabList onChange={handleChange} aria-label="lab API tabs example" className='BTSTabList' variant="fullWidth">
                                            <Tab label="Phim đang chiếu" value="1" className='BTSTab' />
                                            <Tab label="Phim sắp chiếu" value="2" className='BTSTab' />
                                            <Tab label="Suất chiếu đặc biệt" value="3" className='BTSTab' />
                                            <Tab label="Bảng giá vé" value="4" className='BTSTab' />
                                        </TabList>
                                    </Box>
                                    <TabPanel value="1">
                                        <div className="re-head">
                                            <h2 className="heading --t-center">PHIM ĐANG CHIẾU</h2>
                                        </div>
                                        {
                                            Array.isArray(listMovieByTheaterId) && isCurrentMovie(listMovieByTheaterId).length > 0 ?
                                                (
                                                    <Grid container rowSpacing={1} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
                                                        {
                                                            isCurrentMovie(listMovieByTheaterId).map((item) => (
                                                                    <Grid item xs={6} key={item.id}>
                                                                        <BookTicket bookTicket={item}></BookTicket>
                                                                    </Grid>
                                                            ))
                                                        }
                                                    </Grid>
                                                ) : (
                                                    <div style={{ opacity: 1, transform: 'none' }}>
                                                        <div className="movies-noti">
                                                            <div className="movies-noti-img">
                                                                <img src="/Images/movie-updating.png" alt="" />
                                                            </div>
                                                            <p className="txt">Đang cập nhật</p>
                                                        </div>
                                                    </div>
                                                )
                                        }
                                    </TabPanel>
                                    <TabPanel value="2">
                                        <div className="re-head">
                                            <h2 className="heading --t-center">PHIM SẮP CHIẾU</h2>
                                        </div>
                                        {
                                            Array.isArray(listMovieByTheaterId) && isUpcomingMovie(listMovieByTheaterId).length > 0 ?
                                                (
                                                    <Grid container rowSpacing={1} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
                                                        {
                                                            isUpcomingMovie(listMovieByTheaterId).map((item) => (
                                                                <Grid item xs={6} key={item.id}>
                                                                    <BookTicket bookTicket={item}></BookTicket>
                                                                </Grid>
                                                            ))
                                                        }
                                                    </Grid>
                                                ) : (
                                                    <div style={{ opacity: 1, transform: 'none' }}>
                                                        <div className="movies-noti">
                                                            <div className="movies-noti-img">
                                                                <img src="/Images/movie-updating.png" alt="" />
                                                            </div>
                                                            <p className="txt">Đang cập nhật</p>
                                                        </div>
                                                    </div>
                                                )
                                        }
                                    </TabPanel>
                                    <TabPanel value="3">
                                        <div style={{ opacity: 1, transform: 'none' }}>
                                            <div className="re-head">
                                                <h2 className="heading --t-center">Suất chiếu đặc biệt</h2>
                                            </div>
                                            {
                                                Array.isArray(listMovieByTheaterId) && isSpecialMovie(listMovieByTheaterId).length > 0 ?
                                                    (
                                                        <Grid container rowSpacing={1} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
                                                            {
                                                                isSpecialMovie(listMovieByTheaterId).map((item) => (
                                                                    <Grid item xs={6} key={item.id}>
                                                                        <BookTicket bookTicket={item}></BookTicket>
                                                                    </Grid>
                                                                ))
                                                            }
                                                        </Grid>
                                                    ) : (
                                                        <div style={{ opacity: 1, transform: 'none' }}>
                                                            <div className="movies-noti">
                                                                <div className="movies-noti-img">
                                                                    <img src="/Images/movie-updating.png" alt="" />
                                                                </div>
                                                                <p className="txt">Đang cập nhật</p>
                                                            </div>
                                                        </div>
                                                    )
                                            }
                                        </div>
                                    </TabPanel>
                                </TabContext>
                            </Box>
                        </div>
                    </div>
                </section>
            </div>
        </>
    );
}

export default BookTickets;