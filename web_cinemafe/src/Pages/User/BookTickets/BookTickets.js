import './BookTickets.css'
import { Box, Grid, Tab } from '@mui/material';
import { TabContext, TabList, TabPanel } from '@mui/lab';
import BookTicket from '../../../Components/Film/BookTicket';
import { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { useEffect } from 'react';
import { GetInvoiceAction, ShowTimeByTheaterIdAction, TheaterAction } from '../../../Redux/Actions/CinemasAction';
import { DOMAIN } from '../../../Ustil/Settings/Config';
import moment from 'moment';

const BookTickets = () => {
    let { id } = useParams();

    const currentTime = moment();
    const dispatch = useDispatch();
    const [value, setValue] = useState('1');
    const { theaterDetail, listMovieByTheaterId } = useSelector((state) => state.CinemasReducer)

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    useEffect(() => {
        dispatch(TheaterAction(id))
        dispatch(ShowTimeByTheaterIdAction(id))
    }, [dispatch, id]);

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
                                        <Grid container rowSpacing={1} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
                                            {
                                                Array.isArray(listMovieByTheaterId) && listMovieByTheaterId?.map((item) => {
                                                    if (
                                                        new Date(item.releaseDate) < currentTime
                                                        && item.schedules.length > 0 && item.schedules.some(schedule =>
                                                            schedule.theaters.some(theater =>
                                                                theater.showTimes.some(timeItem => {
                                                                    const currentDate = moment();
                                                                    const threeDaysLater = moment(currentDate).add(2, 'days');

                                                                    const scheduleDate = moment(schedule.date);
                                                                    return (
                                                                        scheduleDate.isBetween(currentDate, threeDaysLater, null, '[]') &&
                                                                        moment(timeItem.startTime).isSameOrAfter(currentDate)
                                                                    );
                                                                }
                                                                )
                                                            )
                                                        )) {
                                                        return (
                                                            <Grid item xs={6}>
                                                                <BookTicket bookTicket={item}></BookTicket>
                                                            </Grid>
                                                        )
                                                    }
                                                })
                                            }
                                        </Grid>
                                    </TabPanel>
                                    <TabPanel value="2">
                                        <div className="re-head">
                                            <h2 className="heading --t-center">PHIM SẮP CHIẾU</h2>
                                        </div>
                                        {
                                            Array.isArray(listMovieByTheaterId) && listMovieByTheaterId?.map((item) => {
                                                if (new Date(item.releaseDate) >= currentTime) {
                                                    return (
                                                        <Grid item xs={6}>
                                                            <BookTicket bookTicket={item}></BookTicket>
                                                        </Grid>
                                                    )
                                                }
                                            })
                                        }
                                    </TabPanel>
                                    <TabPanel value="3">
                                        Item Three
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