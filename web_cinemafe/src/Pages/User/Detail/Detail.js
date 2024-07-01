import { Link, useLocation, useParams } from 'react-router-dom';
import { useDispatch, useSelector } from "react-redux";
import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import 'swiper/css/pagination';
import './Detail.css'
import { Pagination } from 'swiper/modules';
import Theater from '../Theater/Theater';
import { useEffect, useRef, useState } from 'react';
import { ComboAction, MovieDetailAction, SeatAction, TicketTypeAction } from '../../../Redux/Actions/CinemasAction';
import { DOMAIN } from '../../../Ustil/Settings/Config';
import moment from 'moment';
import { MovieDetailDTO } from '../../../Models/MovieDetailDTO';
import { SeatByShowTimeAndRoomDTO } from '../../../Models/SeatByShowTimeAndRoomDTO';
import { InfoTicketBooking, TicketBookingSuccess } from '../../../Models/InfoTicketBooking';
import { CHECK_FOR_EMPTY_SEAT, CLEAN, GET_WAITING_SEAT, LIST_OF_SEATS_SOLD, UPDATE_SEAT } from '../../../Redux/Actions/Type/CinemasType';
import { TicketTypeByShowTimeAndRoomDTO } from '../../../Models/TicketTypeByShowTimeAndRoomDTO';
import { connection } from '../../../connectionSignalR';
import { CSSTransition } from 'react-transition-group';
import { Box, CircularProgress } from '@mui/material';
const Detail = () => {
    const dispatch = useDispatch();
    let { id } = useParams();
    const { movieDetail } = useSelector((state) => state.CinemasReducer)
    let location = useLocation();
    let { projectionForm, selectedShowTime, selectedheaterName, activeDateIndex } = location.state ?? {};
    const queryParams = new URLSearchParams(location.search);
    const theaterId = queryParams.get('id');
    const showTimeId = queryParams.get('show_time');
    const roomId = queryParams.get('room');
    const connectionEstablished = useRef(false);
    const [showTicketType_Seat_Combo, setShowTicketType_Seat_Combo] = useState(false);
    const [selectedShowTimeId, setSelectedShowTimeId] = useState(null);
    const [selectedTheaterId, setSelectedTheaterId] = useState(null);
    const [selectedRoomId, setselectedRoomId] = useState(null);
    const [showTrailerPopup, setShowTrailerPopup] = useState(false);

    useEffect(() => {
        let movieDetailDTO = new MovieDetailDTO();
        movieDetailDTO.id = id;
        movieDetailDTO.projectionForm = projectionForm
        dispatch(MovieDetailAction(movieDetailDTO))
    }, [id, projectionForm]);

    useEffect(() => {
        const showTimeIdHandle = async (showTimeId, roomId, theaterId) => {
            if (!connectionEstablished.current) {
                connection.on("ListOfSeatsSold", (seatInfos) => {
                    dispatch({
                        type: LIST_OF_SEATS_SOLD,
                        seatInfos
                    })
                })

                connection.on("UpdateSeat", (seatInfos, seatStatus) => {
                    dispatch({
                        type: UPDATE_SEAT,
                        seatInfos, seatStatus
                    })
                })

                connection.on("GetWaitingSeat", (seatInfos) => {
                    dispatch({
                        type: GET_WAITING_SEAT,
                        seatInfos
                    })
                })

                connection.on("CheckForEmptySeats", (seatInfos, seatStatus) => {
                    dispatch({
                        type: CHECK_FOR_EMPTY_SEAT,
                        seatInfos, seatStatus
                    })
                })

                await connection.start();
                connectionEstablished.current = true;

                const infoTicketBooking = new InfoTicketBooking()
                infoTicketBooking.showTimeId = showTimeId
                infoTicketBooking.roomId = roomId
                await connection.invoke("JoinShowTime", infoTicketBooking)
            }

            const ticketTypeByShowTimeAndRoomDTO = new TicketTypeByShowTimeAndRoomDTO();
            ticketTypeByShowTimeAndRoomDTO.showTimeId = showTimeId;
            ticketTypeByShowTimeAndRoomDTO.roomId = roomId;

            dispatch(TicketTypeAction(ticketTypeByShowTimeAndRoomDTO))

            const seatByShowTimeAndRoomDTO = new SeatByShowTimeAndRoomDTO();
            seatByShowTimeAndRoomDTO.showTimeId = showTimeId;
            seatByShowTimeAndRoomDTO.roomId = roomId;

            dispatch(SeatAction(seatByShowTimeAndRoomDTO))
            dispatch(ComboAction(theaterId))

            setShowTicketType_Seat_Combo(true)
            setSelectedShowTimeId(showTimeId)
            setSelectedTheaterId(theaterId)
            setselectedRoomId(roomId)
        };

        if (theaterId && showTimeId && roomId) {
            showTimeIdHandle(showTimeId, roomId, theaterId)
        }
    }, [theaterId, showTimeId, roomId, dispatch]);

    return (
        <>
            <div className="app-content">
                <section className="sec-detail">
                    <div className="detail ht">
                        <div className="container">
                            <div className="detail-wr">
                                {
                                    !movieDetail ? (
                                        <Box sx={{ textAlign: 'center' }}>
                                            <CircularProgress />
                                        </Box>
                                    ) :
                                        (
                                            <div className="detail-row row">
                                                <div className='detail-left col col-5'>
                                                    <div class="web-movie-box">
                                                        <div className="web-movie-box">
                                                            <div className="image">
                                                                <img src={`${DOMAIN}/Images/${movieDetail?.image}`} alt=""></img>
                                                                <div className="attach">
                                                                    <div className="type-movie">
                                                                        <span className="txt">{movieDetail?.showTimeTypeName}</span>
                                                                    </div>
                                                                    <div className="age">
                                                                        <span className="number">
                                                                            {movieDetail?.ageRestrictionName}
                                                                        </span>
                                                                        <span className="txt">
                                                                            {movieDetail?.ageRestrictionAbbreviation ? movieDetail?.ageRestrictionAbbreviation.toUpperCase() : ''}
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className='detail-right col col-7'>
                                                    <div className='detail-ct'>
                                                        <div className='detail-ct-h'>
                                                            <h1 className='heading'>
                                                                {movieDetail?.name} ({movieDetail?.ageRestrictionName})
                                                            </h1>
                                                            <ul className='info-detail'>
                                                                <li className='info-item'>
                                                                    <span class="ic">
                                                                        <img src="/Images/movieType.svg" alt="Movie Type Icon" width="100" height="100" />
                                                                    </span>
                                                                    <span class="txt">{movieDetail?.movieType}</span>
                                                                </li>
                                                                <li className='info-item'>
                                                                    <span class="ic">
                                                                        <img src="/Images/icon-clock.svg" alt="Clock icon" />
                                                                    </span>
                                                                    <span class="txt">{movieDetail?.time}'</span>
                                                                </li>
                                                                <li className='info-item'>
                                                                    <span class="ic">
                                                                        <img src="/Images/earth-americas.svg" alt="Earth americas Icon" width="100" height="100" />
                                                                    </span>
                                                                    <span class="txt">Khác</span>
                                                                </li>
                                                                <li className='info-item'>
                                                                    <span class="ic">
                                                                        <img src="/Images/user-check.svg" alt="User check Icon" width="100" height="100" />
                                                                    </span>
                                                                    <span class="txt">{movieDetail?.ageRestrictionName}: {movieDetail?.ageRestrictionDescription}</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div className='detail-ct-bd'>
                                                            <h3 className='tt sub-tittle'>
                                                                Mô tả
                                                            </h3>
                                                            <ul className='font-family-actor'>
                                                                <li>Đạo diễn: {movieDetail?.director}</li>
                                                                <li>Diễn viên: {movieDetail?.actor}</li>
                                                                <li>Khởi chiếu: {moment(movieDetail?.releaseDate).format("DD/MM/YYYY")}</li>
                                                            </ul>
                                                        </div>
                                                        <div className='detail-ct-bd'>
                                                            <h3 className='tt sub-tittle'>
                                                                Nội dung phim
                                                            </h3>
                                                            <div className='ct'>
                                                                <div className='dt'>
                                                                    <p class="txt line-clamp-6 description">{movieDetail?.description}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div className='detail-ct-ft' onClick={() => setShowTrailerPopup(true)}>
                                                            <div class="video pointer">
                                                                <span class="ic">
                                                                    <img src="https://cinestar.com.vn/assets/images/icon-play-vid.svg" alt=''></img>
                                                                </span>
                                                                <span class="txt">Xem Trailer</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        )
                                }
                            </div>
                        </div>
                    </div>
                </section>
                <Theater
                    MovieDetail={movieDetail}
                    theaterId={selectedTheaterId}
                    showTimeId={selectedShowTimeId}
                    roomId={selectedRoomId}
                    showTicketType_Seat_Combo={showTicketType_Seat_Combo}
                    selectedShowTime={selectedShowTime}
                    selectedheaterName={selectedheaterName}
                    activeDateIndex={activeDateIndex}
                />
            </div>

            <CSSTransition
                in={showTrailerPopup}
                unmountOnExit
                timeout={{ enter: 0, exit: 300 }}
            >
                <div className="modal" onClick={() => setShowTrailerPopup(false)}>
                    <iframe
                        style={{ position: "relative" }}
                        title="title4"
                        allowfullscreen="true"
                        width="996px"
                        height="500px"
                        src={`https://www.youtube.com/embed/${movieDetail.trailer}`}
                        frameborder="0"
                    ></iframe>
                </div>
            </CSSTransition>
        </>
    );
}

export default Detail;