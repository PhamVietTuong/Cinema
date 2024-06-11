import { Box, Button, FormControl, InputLabel, MenuItem, Select } from '@mui/material';
import './BookQuickTicket.css'
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { ListMovieByTheaterIdAction } from '../../../Redux/Actions/CinemasAction';

const BookQuickTicket = (props) => {
    const [theaterId, setTheaterId] = useState(null);
    const [movieId, setMovieId] = useState({movieId: null, projectionForm: null});
    const [date, setDate] = useState(null);
    const [showTimeId, setshowTimeId] = useState(null);
    const dispatch = useDispatch();
    const { listMovieByTheaterIdBookQuickTicket } = useSelector((state) => state.CinemasReducer)

    useEffect(() => {
        dispatch(ListMovieByTheaterIdAction(theaterId))
    }, [dispatch,theaterId]);

    return (
        <>
            <div className="container">
                <div className="navigate-wrap" data-aos="fade-up">
                    <div className="heading">
                        <h1>Đặt vé nhanh</h1>
                    </div>
                    <div className="navigate-filter">
                        <FormControl fullWidth>
                            <InputLabel className='BQTInputLabel'>1. Chọn rạp</InputLabel>
                            <Select
                                value={theaterId}
                                label="1. Chọn rạp"
                                className='isActive BQTSelect'
                                onChange={(e) => { setTheaterId(e.target.value) }}
                            >
                                {
                                    props.theaterList.map((item) => (
                                        <MenuItem value={item.id} className='BQTMenuItem'>{item.name}</MenuItem>
                                    ))
                                }
                            </Select>
                        </FormControl>
                        <FormControl fullWidth>
                            <InputLabel className='BQTInputLabel'>2. Chọn phim</InputLabel>
                            <Select
                                value={movieId}
                                label="1. Chọn rạp"
                                className='BQTSelect'
                                onChange={(e) => { console.log(e); }}
                            >
                                {
                                    listMovieByTheaterIdBookQuickTicket.map((item) => (
                                        <MenuItem value={item.id} className='BQTMenuItem'>{item.name} {item.showTimeTypeName} {`(${item.ageRestrictionName})`}</MenuItem>
                                    ))
                                }
                            </Select>
                        </FormControl>
                        <FormControl fullWidth>
                            <InputLabel className='BQTInputLabel'>3. Chọn ngày</InputLabel>
                            <Select
                                value={date}
                                label="1. Chọn rạp"
                                className='BQTSelect'
                                onChange={(e) => { setDate(e.target.value) }}
                            >
                                <MenuItem value={10} className='BQTMenuItem'>Ten</MenuItem>
                                <MenuItem value={20} className='BQTMenuItem'>Twenty</MenuItem>
                                <MenuItem value={30} className='BQTMenuItem'>Thirty</MenuItem>
                            </Select>
                        </FormControl>
                        <FormControl fullWidth>
                            <InputLabel className='BQTInputLabel'>4. Chọn suất</InputLabel>
                            <Select
                                value={showTimeId}
                                label="1. Chọn rạp"
                                className='BQTSelect'
                                onChange={(e) => { setshowTimeId(e.target.value) }}
                            >
                                <MenuItem value={10} className='BQTMenuItem'>Ten</MenuItem>
                                <MenuItem value={20} className='BQTMenuItem'>Twenty</MenuItem>
                                <MenuItem value={30} className='BQTMenuItem'>Thirty</MenuItem>
                            </Select>
                        </FormControl>
                        <div className="navigate-filter-btn">
                            {/* preventClick check */}
                            <Button variant="contained" className="btn btn--second "> Đặt ngay</Button>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}

export default BookQuickTicket;