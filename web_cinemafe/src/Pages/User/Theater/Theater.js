import './Theater.css'
import { Nav, Tab, } from 'react-bootstrap';
import React, { useEffect, useState } from 'react';
import { Collapse } from 'react-collapse';
import moment from 'moment';
import 'moment/locale/vi';
import SeatType from '../SeatType/SeatType';
import Seat from '../Seat/Seat';
import FoodAndDrink from '../FoodAndDrink/FoodAndDrink';
import Bill from '../Bill/Bill';
import { useDispatch, useSelector } from "react-redux";
import { ComboAction, SeatAction, SeatBeingSelected, TicketBooking, TicketTypeAction } from '../../../Redux/Actions/CinemasAction';
import { TicketBookingSuccess } from '../../../Models/TicketBookingSuccess';
import { CHECK_FOR_EMPTY_SEAT, GET_WAITING_SEAT, LIST_OF_SEATS_SOLD, SEAT_BEING_SELECTED, UPDATE_SEAT } from '../../../Redux/Actions/Type/CinemasType';
import { connection } from '../../../connectionSignalR';
import { TicketTypeByShowTimeAndRoomDTO } from '../../../Models/TicketTypeByShowTimeAndRoomDTO';
import { SeatByShowTimeAndRoomDTO } from '../../../Models/SeatByShowTimeAndRoomDTO';
import { SeatStatus } from '../../../Enum/SeatStatus';
import { DOMAIN } from '../../../Ustil/Settings/Config';
import { ShowTimeType } from '../../../Enum/ShowTimeType';

const Theater = (props) => {
    const dispatch = useDispatch();
    const {
        ticketType,
        seat,
        combo,
        listOfSeatSold,
        seatYour,
        listWattingSeat,
        updateSeat
    } = useSelector((state) => state.CinemasReducer);
    const [activeIndex, setActiveIndex] = useState(0);
    const [showTicketType_Seat_Combo, setShowTicketType_Seat_Combo] = useState(false);
    const [selectedheaterName, setSelectedTheaterName] = useState(null);
    const [selectedSeatName, setSelectedSeatName] = useState([]);
    const [selectedShowTimeId, setSelectedShowTimeId] = useState(null);
    const [countdown, setCountdown] = useState(300);
    const [timerRunning, setTimerRunning] = useState(false);
    const [selectedRoomId, setselectedRoomId] = useState(null);

    useEffect(() => {
        if (timerRunning && countdown > 0) {
            const timer = setTimeout(() => {
                setCountdown(prevCountdown => prevCountdown - 1);
            }, 1000);

            return () => clearTimeout(timer);
        } else if (countdown === 0) {
            window.location.reload();

        }
    }, [timerRunning, countdown]);

    const minutes = Math.floor(countdown / 60);
    const seconds = countdown % 60;

    const handleSeatSelect = (seatId, showTimeId, roomId) => {
        setTimerRunning(false);
        setCountdown(300);
        setTimerRunning(true);
        dispatch(SeatBeingSelected(seatId, showTimeId, roomId));
    }

    const showTimeIdHandele = async (showTimeId, roomId, theaterId) => {
        if (connection) {
            await connection.stop();
            await dispatch({
                type: SEAT_BEING_SELECTED,
                here: false
            });
        }

        connection.on("ListOfSeatsSold", (seatIds) => {
            dispatch({
                type: LIST_OF_SEATS_SOLD,
                seatIds
            })
        })

        connection.on("UpdateSeat", (seatId, seatStatus) => {
            dispatch({
                type: UPDATE_SEAT,
                seatId, seatStatus
            })
        })

        connection.on("GetWaitingSeat", (seatIds) => {
            dispatch({
                type: GET_WAITING_SEAT,
                seatIds
            })
        })

        connection.on("CheckForEmptySeats", (seatId, seatStatus) => {
            dispatch({
                type: CHECK_FOR_EMPTY_SEAT,
                seatId, seatStatus
            })
        })

        await connection.start();

        const ticketBookingSuccess = new TicketBookingSuccess()
        ticketBookingSuccess.showTimeId = showTimeId
        ticketBookingSuccess.roomId = roomId
        await connection.invoke("JoinShowTime", ticketBookingSuccess)

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
        setselectedRoomId(roomId)
    }

    const renderSeats = (seatItem) => {
        return seatItem.rowSeats.map((rowSeatItem, rowSeatIndex) => {
            let classSeated = rowSeatItem.seatStatus === SeatStatus.Sold ? 'booked' : '';
            let classSeatBeingSelected = seatYour.includes(rowSeatItem.id) ? 'choosing' : '';
            
            let classSeatSold = listOfSeatSold.includes(rowSeatItem.id) ? 'booked' : ''

            let classUpdateSeat = updateSeat.includes(rowSeatItem.id) ? 'update' : ''
            let classWattingSeat = listWattingSeat && listWattingSeat.includes(rowSeatItem.id) ? 'update' : '';

            return (
                rowSeatItem.name
                    ?
                    (
                        <td className="seat-td"
                            disabled
                            onClick={() => {
                                if (!rowSeatItem.isSold && !classUpdateSeat) {
                                    handleSeatSelect(rowSeatItem.id, selectedShowTimeId, selectedRoomId)
                                }
                            }}
                        >
                            <div className={`seat-wr seat-single ${classSeatSold} ${classUpdateSeat} ${classWattingSeat} ${classSeated} ${classSeatBeingSelected}`} >
                                <img
                                    src="https://cinestar.com.vn/assets/images/seat-single.svg"
                                    alt=""
                                />
                                <span className="seat-name">{rowSeatItem.name}</span>
                            </div>
                        </td>
                    )
                    :
                    (
                        <td />
                    )
            )
        })
    }

    return (
        <>
            <section className="sec-shtime">
                <div className="shtime">
                    <div className="container">
                        <div className="shtime-wr">
                            <Tab.Container id="left-tabs-example" defaultActiveKey="tab-0">
                                <div className="shtime-heading" data-aos="fade-up">
                                    <h2 className="heading">LỊCH CHIẾU</h2>
                                    <div className="shtime-slider time-list">
                                        <div className="swiper-container">
                                            <Nav variant="pills" className='swiper'>
                                                {
                                                    props.MovieDetail?.schedules?.map((scheduleItem, scheduleIndex) => (
                                                        <Nav.Item onClick={() => {
                                                            setShowTicketType_Seat_Combo(false);
                                                        }}>
                                                            <Nav.Link eventKey={`tab-${scheduleIndex}`} className='swiper-slide'>
                                                                <div class="box-time">
                                                                    <p class="date">{moment(scheduleItem.date).format("DD/MM")}</p>
                                                                    <p class="day">{moment(scheduleItem.date).format("dddd").replace(/^\w/, (c) => c.toUpperCase())}</p>
                                                                </div>
                                                            </Nav.Link>
                                                        </Nav.Item>
                                                    ))
                                                }
                                            </Nav>
                                        </div>
                                    </div>
                                </div>
                                <div className="shtime-body">
                                    <h2 className="heading">Danh sách Rạp</h2>
                                </div>
                                <Tab.Content>
                                    {props.MovieDetail?.schedules?.map((scheduleItem, scheduleIndex) => (
                                        <Tab.Pane key={scheduleIndex} eventKey={`tab-${scheduleIndex}`}>
                                            <div className="shtime-ft">
                                                <ul className="cinestar-list">
                                                    {scheduleItem.theaters.map((theaterItem, theaterIndex) => (
                                                        <React.Fragment key={theaterIndex}>
                                                            <li className={`cinestar-item collapseItem ${activeIndex === theaterIndex ? 'active' : ''}`}>
                                                                <div className="cinestar-heading" onClick={() => setActiveIndex(activeIndex === theaterIndex ? null : theaterIndex)}>
                                                                    <h4 className="tittle">{theaterItem.theaterName}</h4>
                                                                    <i className={`fa-solid fa-angle-${activeIndex === theaterIndex ? 'up' : 'down'} icon`} />
                                                                </div>
                                                                <Collapse isOpened={activeIndex === theaterIndex}>
                                                                    <div className="cinestar-body collapseBody">
                                                                        <p className="addr">
                                                                            {theaterItem.theaterAddress}
                                                                        </p>
                                                                        <ul className="list-info">
                                                                            <li className="item-info">
                                                                                <div className="tt">Standard</div>
                                                                                <ul className="list-time">
                                                                                    {
                                                                                        theaterItem.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Standard).map((timeItem, timeIndex) => (
                                                                                            <li key={timeIndex} className="item-time"
                                                                                                onClick={() => {
                                                                                                    showTimeIdHandele(timeItem.showTimeId, timeItem.roomId, theaterItem.theaterId);
                                                                                                    setSelectedTheaterName(theaterItem.theaterName);
                                                                                                }}>
                                                                                                {moment(timeItem.startTime).format("HH:mm")}
                                                                                            </li>
                                                                                        ))
                                                                                    }
                                                                                    <li className="disable item-time">08:15</li>
                                                                                </ul>
                                                                            </li>
                                                                            <li className="item-info">
                                                                                <div className="tt">Deluxe</div>
                                                                                <ul className="list-time">
                                                                                    {
                                                                                        theaterItem.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Deluxe).map((timeItem, timeIndex) => (
                                                                                            <li key={timeIndex} className="item-time"
                                                                                                onClick={() => {
                                                                                                    showTimeIdHandele(timeItem.showTimeId, timeItem.roomId, theaterItem.theaterId);
                                                                                                    setSelectedTheaterName(theaterItem.theaterName);
                                                                                                }}>
                                                                                                {moment(timeItem.startTime).format("HH:mm")}
                                                                                            </li>
                                                                                        ))
                                                                                    }
                                                                                    <li className="disable item-time">18:15</li>
                                                                                </ul>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </Collapse>
                                                            </li>
                                                        </React.Fragment>
                                                    ))}
                                                </ul>
                                            </div>
                                        </Tab.Pane>
                                    ))}
                                    <Tab.Pane eventKey="second">
                                        content
                                    </Tab.Pane>
                                </Tab.Content>
                            </Tab.Container>
                        </div>
                    </div>
                </div>
            </section>

            {showTicketType_Seat_Combo && (
                <>
                    <section className="sec-ticket bill-fixed-start">
                        <div className="ticket">
                            <div className="container">
                                <div className="tickett-wr">
                                    <div className="ticket-heading sec-heading">
                                        <h2 className="heading">Chọn loại vé</h2>
                                    </div>
                                    <div className="ticket-container relative">
                                        <div className="ticket-ct">
                                            <div className="combo-content">
                                                <div className="combo-list row" data-aos="fade-up">
                                                    {
                                                        ticketType.map((ticketItem, ticketIndex) => (
                                                            <div className="combo-item col col-4">
                                                                <div className="food-box">
                                                                    <div className="content">
                                                                        <div className="content-top">
                                                                            <p className="name sub-title cursor-pointer">
                                                                                {ticketItem.ticketTypeName}
                                                                            </p>
                                                                            <div className="desc">
                                                                                <p>{ticketItem.seatTypeName}</p>
                                                                            </div>
                                                                            <div className="price sub-title">
                                                                                <p>{ticketItem.price.toLocaleString("en-US").replace(/,/g, ".")} VNĐ</p>
                                                                            </div>
                                                                        </div>
                                                                        <div className="content-bottom">
                                                                            <div className="count">
                                                                                <div className="count-btn count-minus">
                                                                                    <i className="fas fa-minus icon" />
                                                                                </div>
                                                                                <p className="count-number">0</p>
                                                                                <div className="count-btn count-plus">
                                                                                    <i className="fas fa-plus icon" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        ))
                                                    }
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    {
                        <section className="sec-seat">
                            <div className="seat">
                                <div className="container">
                                    <div className="seat-wr">
                                        <div className="seat-heading sec-heading" data-aos="fade-up">
                                            <h2 className="heading">Chọn ghế - Rạp {seat?.roomName} </h2>
                                        </div>
                                        <div className="seat-indicator-scroll">
                                            <div className="seat-block relative --full">
                                                <div className="seat-screen" data-aos="fade-up">
                                                    <img src="https://cinestar.com.vn/assets/images/img-screen.png" alt=''/>
                                                    <div className="txt">Màn hình</div>
                                                </div>
                                                <div className="seat-main" data-aos="fade-up">
                                                    <div className="minimap-container ">
                                                        <div>
                                                            <div className="seat-table">
                                                                <table className="seat-table-inner">
                                                                    <tbody>
                                                                        {
                                                                            seat?.rowName?.map((seatItem, seatIndex) => (
                                                                                <tr>
                                                                                    <td className="seat-name-row">{seatItem.rowName}</td>
                                                                                    {
                                                                                        renderSeats(seatItem)
                                                                                    }
                                                                                </tr>
                                                                            ))
                                                                        }
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <ul className="seat-note">
                                            <li className="note-it">
                                                <div className="image">
                                                    {" "}
                                                    <img src="	https://cinestar.com.vn/assets/images/seat-single.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế Thường</span>
                                            </li>
                                            <li className="note-it note-it-couple">
                                                <div className="image">
                                                    {" "}
                                                    <img src="https://cinestar.com.vn/assets/images/seat-couple.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế Đôi</span>
                                            </li>
                                            <li className="note-it">
                                                <div className="image">
                                                    {" "}
                                                    <img src="https://cinestar.com.vn/assets/images/seat-vip.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế Vip</span>
                                            </li>
                                            <li className="note-it">
                                                <div className="image">
                                                    {" "}
                                                    <img src="https://cinestar.com.vn/assets/images/seat-single-selecting.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế chọn</span>
                                            </li>
                                            <li className="note-it">
                                                <div className="image">
                                                    {" "}
                                                    <img src="https://cinestar.com.vn/assets/images/seat-single-disable.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế đã đặt</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </section>
                    }

                    <section className="sec-dt-food">
                        <div className="dt-food">
                            <div className="container">
                                <div className="dt-food-wr">
                                    <div className="dt-food-heading sec-heading" data-aos="fade-up">
                                        <h2 className="heading">Chọn bắp nước</h2>
                                    </div>
                                    <div className="dt-food-body">
                                        <div className="dt-combo dt-item" data-aos="fade-up">
                                            <div className="combo-tile">
                                                <div className="title">COMBO 2 NGĂN</div>
                                            </div>
                                            <div className="combo-content">
                                                <div className="combo-list row">
                                                    {combo.map((comboItem, comboIndex) => (
                                                        <div className="combo-item col col-4">
                                                            <div className="food-box">
                                                                <div className="img">
                                                                    <div className="image">
                                                                        <img
                                                                            src={`${DOMAIN}/Images/${comboItem.image}`}
                                                                            alt=""
                                                                        />
                                                                    </div>
                                                                </div>
                                                                <div className="content">
                                                                    <div className="content-top">
                                                                        <p className="name sub-title cursor-pointer">
                                                                            {comboItem.name}
                                                                        </p>
                                                                        <div className="desc">
                                                                            <p>
                                                                                {comboItem.description}
                                                                            </p>
                                                                        </div>
                                                                        <div className="price sub-title">
                                                                            <p>{comboItem.price.toLocaleString("en-US").replace(/,/g, ".")} đ </p>
                                                                        </div>
                                                                    </div>
                                                                    <div className="content-bottom">
                                                                        <div className="count">
                                                                            <div className="count-btn count-minus">
                                                                                <i className="fas fa-minus icon" />
                                                                            </div>
                                                                            <p className="count-number">0</p>
                                                                            <div className="count-btn count-plus">
                                                                                <i className="fas fa-plus icon" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    ))}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <div className="dt-bill bill-fixed bill-custom">
                        <div className="container">
                            <div className="bill-wr" data-aos="fade-up">
                                <div className="bill-left">
                                    <h4 className="name-combo">{props.MovieDetail?.name} ({props.MovieDetail?.ageRestrictionName})</h4>
                                    <ul className="list">
                                        <li className="item">
                                            <span className="txt">{selectedheaterName}</span>
                                            <span className="dot">|</span>
                                            <span className="txt">2 HSSV-Người Cao Tuổi</span>
                                        </li>
                                        <li className="item">
                                            <span className="txt">Phòng chiếu :</span>
                                            <span className="txt">{seat?.roomName}</span>
                                            <span className="dot">|</span>
                                            <span className="txt">{selectedSeatName}</span>
                                            <span className="dot">|</span>
                                            <span className="dot">16:45</span>
                                        </li>
                                        <li className="item">
                                            <span className="txt" />
                                        </li>
                                    </ul>
                                </div>
                                <div className="bill-custom-right">
                                    <div className="bill-coundown">
                                        <p className="txt">Thời gian giữ vé:</p>
                                        <div className="bill-time">
                                            <span className="item" id="timer">
                                                {minutes < 10 ? `0${minutes}` : minutes}:{seconds < 10 ? `0${seconds}` : seconds}
                                            </span>
                                        </div>
                                    </div>
                                    <div className="bill-right">
                                        <div className="price">
                                            <span className="txt">Tạm tính </span>
                                            <span className="num">90,000 đ</span>
                                        </div>
                                        <button className="btn btn-warning opacity-100"
                                            onClick={() => {
                                                const ticketBookingSuccess = new TicketBookingSuccess();
                                                ticketBookingSuccess.showTimeId = selectedShowTimeId
                                                ticketBookingSuccess.seatIds = seatYour
                                                ticketBookingSuccess.roomId = selectedRoomId
                                                dispatch(TicketBooking(ticketBookingSuccess))
                                            }}
                                        >ĐẶT VÉ</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </>
            )}
        </>
    )
}

export default Theater;