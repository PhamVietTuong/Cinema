import './Theater.css'
import './SeatType.css'
import './Seat.css'
import './FoodAndDrink.css'
import './Bill.css'
import { Nav, Tab } from 'react-bootstrap';
import React, { useEffect, useState } from 'react';
import { Collapse } from 'react-collapse';
import moment from 'moment';
import 'moment/locale/vi';
import { useDispatch, useSelector } from "react-redux";
import { ComboAction, SeatAction, SeatBeingSelected, TicketBooking, TicketTypeAction, updateTotalSeatTypeAndProceed } from '../../../Redux/Actions/CinemasAction';
import { TicketBookingSuccess } from '../../../Models/TicketBookingSuccess';
import { CHECK_FOR_EMPTY_SEAT, CLEAN, GET_WAITING_SEAT, LIST_OF_SEATS_SOLD, TOTAL_CHOOSES_SEAT_TYPE, UPDATE_SEAT } from '../../../Redux/Actions/Type/CinemasType';
import { connection } from '../../../connectionSignalR';
import { TicketTypeByShowTimeAndRoomDTO } from '../../../Models/TicketTypeByShowTimeAndRoomDTO';
import { SeatByShowTimeAndRoomDTO } from '../../../Models/SeatByShowTimeAndRoomDTO';
import { SeatStatus } from '../../../Enum/SeatStatus';
import { DOMAIN } from '../../../Ustil/Settings/Config';
import { ShowTimeType } from '../../../Enum/ShowTimeType';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faMinus, faPlus } from '@fortawesome/free-solid-svg-icons';
import Swal from 'sweetalert2';
import TicketInfo from '../../../Components/ticketInfo/TicketInfo'
import { InvoiceDTO } from '../../../Models/InvoiceDTO'
import { SeatType } from '../../../Enum/SeatType'

const Theater = (props) => {
    const dispatch = useDispatch();
    const {
        ticketType,
        seat,
        combo,
        listOfSeatSold,
        seatYour,
        listWattingSeat,
        updateSeat,
        checkBooking,
    } = useSelector((state) => state.CinemasReducer);
    const [activeIndex, setActiveIndex] = useState(0);
    const [showTicketType_Seat_Combo, setShowTicketType_Seat_Combo] = useState(false);
    const [selectedheaterName, setSelectedTheaterName] = useState(null);
    const [selectedShowTime, setSelectedShowTime] = useState(null);
    const [selectedShowTimeId, setSelectedShowTimeId] = useState(null);
    const [selectedTheaterId, setSelectedTheaterId] = useState(null);
    const [countdown, setCountdown] = useState(300);
    const [timerRunning, setTimerRunning] = useState(false);
    const [selectedRoomId, setselectedRoomId] = useState(props.roomId);
    const [countTicketTypes, setCountTicketTypes] = useState(
        ticketType.reduce((acc, ticket) => {
            if (!acc[ticket.ticketTypeId]) {
                acc[ticket.seatTypeId] = {};
            }
            acc[ticket.seatTypeId][ticket.ticketTypeId] = 0;
            return acc;
        }, {}));
    const [countCombos, setCountCombos] = useState(
        combo.reduce((acc, combo) => {
            acc[combo.id] = 0;
            return acc;
        }, {}));
    const [selectedShowTimeColorActiveId, setSelectedShowTimeColorActiveId] = useState({ showTimeId: null, roomId: null });
    const [totalPrice, setTotalPrice] = useState(0);
    const [show, setShow] = useState(false);
    const [hasShownHSSVWarning, setHasShownHSSVWarning] = useState(false);
    const [seatYourName, setSeatYourName] = useState();
    const [selectedTicketTypeName, setSelectedTTicketTypeName] = useState();
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
    const [invoiceTickets, setInvoiceTickets] = useState([]);
    useEffect(() => {
        if (props.theaterId && props.showTimeId && props.roomId && props.selectedShowTime && props.selectedheaterName) {
            setSelectedShowTimeId(props.showTimeId)
            setSelectedTheaterId(props.theaterId)
            setselectedRoomId(props.roomId)
            setShowTicketType_Seat_Combo(props.showTicketType_Seat_Combo)
            setSelectedTheaterName(props.selectedheaterName)
            setSelectedShowTime(props.selectedShowTime)
            setSelectedShowTimeColorActiveId({ showTimeId: props.showTimeId, roomId: props.roomId })

        }
    }, [props.showTimeId, props.theaterId, props.roomId, props.showTicketType_Seat_Combo, props.selectedShowTime, props.selectedheaterName]);

    useEffect(() => {
        if (timerRunning && countdown > 0) {
            const timer = setTimeout(() => {
                setCountdown(prevCountdown => prevCountdown - 1);
            }, 1000);

            return () => clearTimeout(timer);
        } else if (countdown === 0) {
            // setShow(true)
            Swal.fire({
                title: "ĐÃ HẾT THỜI GIAN GIỮ VÉ",
                padding: "15px",
                width: "400px",
                customClass: {
                    confirmButton: 'custom-ok-button'
                },
                showCancelButton: false,
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.reload();
                }
            })
        }
    }, [timerRunning, countdown]);

    const minutes = Math.floor(countdown / 60);
    const seconds = countdown % 60;

    useEffect(() => {
        let newTotalPrice = 0;

        Object.entries(countTicketTypes).forEach(([seatTypeId, ticketCounts]) => {
            Object.entries(ticketCounts).forEach(([ticketTypeId, count]) => {
                const ticket = ticketType.find(t => t.ticketTypeId === ticketTypeId && t.seatTypeId === seatTypeId);
                if (ticket) {
                    newTotalPrice += count * ticket.price;
                }
            });
        });

        Object.entries(countCombos).forEach(([comboId, count]) => {
            const comboHasValue = combo.find(c => c.id === comboId);
            if (comboHasValue) {
                newTotalPrice += count * comboHasValue.price;
            }
        });

        setTotalPrice(newTotalPrice);
    }, [countTicketTypes, countCombos]);

    useEffect(() => {
        setSelectedTTicketTypeName(getTicketNames(ticketType, countTicketTypes))
    }, [countTicketTypes, ticketType]);

    useEffect(() => {
        setSeatYourName(getSeatNames(seatYour, seat))
        setInvoiceTickets(assignTicketsToSeats(seatYour, countTicketTypes, seat));
    }, [seatYour]);

    useEffect(() => {
        let totalSeatType = Object.entries(countTicketTypes).map(([key, value]) => [key, Object.values(value).reduce((acc, curr) => acc + curr, 0)])
            .reduce((obj, [key, value]) => ({ ...obj, [key]: value }), {})

        dispatch(updateTotalSeatTypeAndProceed(totalSeatType, selectedShowTimeId, selectedRoomId));

    }, [countTicketTypes]);


    const formatCurrency = (value) => {
        return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
    };

    const handleSeatSelect = (seatId) => {
        setTimerRunning(false);
        setCountdown(300);
        setTimerRunning(true);

        dispatch(SeatBeingSelected(seatId, selectedShowTimeId, selectedRoomId));
    }

    const showTimeIdHandele = async (showTimeId, roomId, theaterId) => {
        if (connection) {
            await connection.stop();

            await dispatch({
                type: CLEAN,
            });
            setCountTicketTypes({});
            setCountCombos({});
            setHasShownHSSVWarning(false)
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

    const incrementTicketType = (ticketTypeId, seatTypeId) => {
        setCountTicketTypes(prevCounts => {
            // const totalTickets = Object.values(prevCounts).reduce(
            //     (acc, ticketCounts) => acc + Object.values(ticketCounts).reduce((a, c) => a + c, 0),
            //     0
            // );
            // if (totalTickets === 8) {
            //     Swal.fire({
            //         title: `Vui lòng chọn tối đa <span class="c-second">8</span> ghế`,
            //         padding: "24px",
            //         width: "400px",
            //         customClass: {
            //             confirmButton: 'custom-ok-button'
            //         }
            //     });

            //     return prevCounts
            // }
            if (
                !!ticketType.find(x => x.ticketTypeName === "Hssv - Người cao tuổi" && x.ticketTypeId === ticketTypeId && x.seatTypeId === seatTypeId) &&
                !hasShownHSSVWarning
            ) {
                Swal.fire({
                    text: "Bạn đang mua hạng vé đặc biệt dành cho HSSV, U22 hoặc người cao tuổi. Vui lòng mang theo CCCD hoặc thẻ HSSV có dán ảnh để xác minh trước khi vào rạp. Nhân viên rạp có thể từ chối không cho bạn vào xem nếu không thực hiện đúng quy định này. Trân trọng cảm ơn",
                    padding: "24px",
                    width: "400px",
                    customClass: {
                        confirmButton: 'custom-ok-button'
                    },
                    confirmButtonText: "Đồng ý",
                })
                setHasShownHSSVWarning(true);
            }

            return {
                ...prevCounts,
                [seatTypeId]: {
                    ...prevCounts[seatTypeId],
                    [ticketTypeId]: (prevCounts[seatTypeId]?.[ticketTypeId] || 0) + 1
                }
            };
        });
    };

    const decrementTicketType = (ticketTypeId, seatTypeId) => {
        setCountTicketTypes(prevCounts => {
            let hssv = ticketType.find(x => x.ticketTypeName === "Hssv - Người cao tuổi" && x.ticketTypeId === ticketTypeId && x.seatTypeId === seatTypeId)
            if (!!hssv) {
                let currentCount = prevCounts[hssv.seatTypeId]?.[hssv.ticketTypeId] || 0;

                if (currentCount === 1) {
                    setHasShownHSSVWarning(false);
                }
            }

            const newCounts = {
                ...prevCounts,
                [seatTypeId]: {
                    ...prevCounts[seatTypeId],
                    [ticketTypeId]: (prevCounts[seatTypeId]?.[ticketTypeId] || 0) > 0 ? prevCounts[seatTypeId][ticketTypeId] - 1 : 0
                }
            };

            if (newCounts[seatTypeId][ticketTypeId] === 0) {
                delete newCounts[seatTypeId][ticketTypeId];
                if (Object.keys(newCounts[seatTypeId]).length === 0) {
                    delete newCounts[seatTypeId];
                }
            }

            return newCounts;
        });
    };

    const incrementCombo = (id) => {
        setCountCombos(prevCounts => ({
            ...prevCounts,
            [id]: (prevCounts[id] || 0) + 1
        }));
    };

    const decrementCombo = (id) => {
        setCountCombos(prevCounts => {
            const newCounts = {
                ...prevCounts,
                [id]: prevCounts[id] > 0 ? prevCounts[id] - 1 : 0
            };
            if (newCounts[id] === 0) {
                delete newCounts[id];
            }
            return newCounts;
        });
    };

    const findSeatById = (seatId, seats) => {
        for (let row of seats.rowName) {
            for (let seat of row.rowSeats) {
                if (seat.id === seatId) {
                    return seat;
                }
            }
        }
        return null;
    };

    const assignTicketsToSeats = (selectedSeats, selectedTicketTypes, seats) => {
        const result = [];
        const seatTypeCount = {};

        for (let seatTypeId in selectedTicketTypes) {
            seatTypeCount[seatTypeId] = {};
            for (let ticketTypeId in selectedTicketTypes[seatTypeId]) {
                seatTypeCount[seatTypeId][ticketTypeId] = selectedTicketTypes[seatTypeId][ticketTypeId];
            }
        }

        for (let seatId of selectedSeats) {
            const seat = findSeatById(seatId, seats);

            if (seat && seat.isSeat !== false) {
                const seatTypeId = seat.seatTypeId;

                if (seatTypeId && seatTypeCount[seatTypeId]) {
                    for (let ticketTypeId in seatTypeCount[seatTypeId]) {
                        if (seatTypeCount[seatTypeId][ticketTypeId] > 0) {
                            result.push({ seatId: seat.id, ticketTypeId: ticketTypeId });
                            seatTypeCount[seatTypeId][ticketTypeId] -= 1;
                            break;
                        }
                    }
                }
            }
        }

        return result;
    };

    const getSeatNames = (seatIds, seatData) => {
        const seatNames = [];
        seatData.rowName?.forEach(row => {
            row.rowSeats.forEach(seat => {
                if (seatIds.includes(seat.id)) {
                    seatNames.push(seat.name);
                }
            });
        });
        return seatNames.join(', ');
    };

    const getTicketNames = (ticketTypes, selectedTicketTypes) => {
        let ticketNames = {};

        for (let seatTypeId in selectedTicketTypes) {
            for (let ticketTypeId in selectedTicketTypes[seatTypeId]) {
                const quantity = selectedTicketTypes[seatTypeId][ticketTypeId];
                const ticketType = ticketTypes.find(ticket =>
                    ticket.ticketTypeId === ticketTypeId && ticket.seatTypeId === seatTypeId
                );
                if (ticketType) {
                    const seatTypeName = ticketType.seatTypeName === "Đôi" ? " (đôi)" : " (đơn)";
                    const ticketName = ticketType.ticketTypeName + seatTypeName;

                    if (quantity > 0) {
                        if (ticketNames[ticketName]) {
                            ticketNames[ticketName] += quantity;
                        } else {
                            ticketNames[ticketName] = quantity;
                        }
                    }
                }
            }
        }

        return Object.entries(ticketNames).map(([name, count]) => `${count} ${name}`).join(', ');
    };

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
                        <td className={`seat-td ${classSeatSold} ${classSeated}`}
                            onClick={() => {
                                if (!rowSeatItem.isSold && !classUpdateSeat) {
                                    handleSeatSelect(rowSeatItem.id)
                                }
                            }}
                        >
                            <div className={`seat-wr seat-single ${classSeatSold} ${classUpdateSeat} ${classWattingSeat} ${classSeated} ${classSeatBeingSelected}`} >
                                {
                                    rowSeatItem.seatTypeName === SeatType.SingleChair
                                        ? <img src="/Images/seat-single.svg" alt="Single Seat" />
                                        : <img src="/Images/seat-couple.svg" alt="Couple Seat" />
                                }

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
                                <div className="shtime-heading">
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
                                                                            {theaterItem.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Standard).length > 0 && (
                                                                                <li className="item-info">
                                                                                    <div className="tt">Standard</div>
                                                                                    <ul className="list-time">
                                                                                        {
                                                                                            theaterItem.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Standard).map((timeItem, timeIndex) => (
                                                                                                <li key={timeIndex}
                                                                                                    className={`item-time ${selectedShowTimeColorActiveId.showTimeId === timeItem.showTimeId && selectedShowTimeColorActiveId.roomId === timeItem.roomId ? 'active' : ''}`}

                                                                                                    onClick={() => {
                                                                                                        showTimeIdHandele(timeItem.showTimeId, timeItem.roomId, theaterItem.theaterId);
                                                                                                        setSelectedTheaterName(theaterItem.theaterName);
                                                                                                        setSelectedShowTimeColorActiveId({ showTimeId: timeItem.showTimeId, roomId: timeItem.roomId })
                                                                                                        setSelectedTheaterId(theaterItem.theaterId)
                                                                                                        setSelectedShowTime(moment(timeItem.startTime).format("HH:mm"))
                                                                                                    }}>
                                                                                                    {moment(timeItem.startTime).format("HH:mm")}
                                                                                                </li>
                                                                                            ))
                                                                                        }
                                                                                        <li className="disable item-time">08:15</li>
                                                                                    </ul>
                                                                                </li>
                                                                            )}
                                                                            {theaterItem.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Deluxe).length > 0 && (
                                                                                <li className="item-info">
                                                                                    <div className="tt">Deluxe</div>
                                                                                    <ul className="list-time">
                                                                                        {
                                                                                            theaterItem.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Deluxe).map((timeItem, timeIndex) => (
                                                                                                <li key={timeIndex} className="item-time"
                                                                                                    onClick={() => {
                                                                                                        showTimeIdHandele(timeItem.showTimeId, timeItem.roomId, theaterItem.theaterId);
                                                                                                        setSelectedTheaterName(theaterItem.theaterName);
                                                                                                        setSelectedShowTimeColorActiveId({ showTimeId: timeItem.showTimeId, roomId: timeItem.roomId })
                                                                                                        setSelectedTheaterId(theaterItem.theaterId)
                                                                                                        setSelectedShowTime(moment(timeItem.startTime).format("HH:mm"))
                                                                                                    }}>
                                                                                                    {moment(timeItem.startTime).format("HH:mm")}
                                                                                                </li>
                                                                                            ))
                                                                                        }
                                                                                        <li className="disable item-time">18:15</li>
                                                                                    </ul>
                                                                                </li>
                                                                            )}
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
                                                <div className="combo-list row">
                                                    {
                                                        ticketType.map((ticketItem, ticketIndex) => (
                                                            <div className="combo-item col col-4" key={ticketIndex}>
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
                                                                                <div className="count-btn count-minus" onClick={() => decrementTicketType(ticketItem.ticketTypeId, ticketItem.seatTypeId)}>
                                                                                    <FontAwesomeIcon icon={faMinus} />
                                                                                </div>
                                                                                <p className="count-number">
                                                                                    {countTicketTypes[ticketItem.seatTypeId]?.[ticketItem.ticketTypeId] || 0}
                                                                                </p>
                                                                                <div className="count-btn count-plus" onClick={() => incrementTicketType(ticketItem.ticketTypeId, ticketItem.seatTypeId)}>
                                                                                    <FontAwesomeIcon icon={faPlus} />
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
                                        <div className="seat-heading sec-heading">
                                            <h2 className="heading">Chọn ghế - Rạp {seat?.roomName} </h2>
                                        </div>
                                        <div className="seat-indicator-scroll">
                                            <div className="seat-block relative --full">
                                                <div className="seat-screen">
                                                    <img src="https://cinestar.com.vn/assets/images/img-screen.png" alt='' />
                                                    <div className="txt">Màn hình</div>
                                                </div>
                                                <div className="seat-main">
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
                                                    <img src="/Images/seat-single.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế Thường</span>
                                            </li>
                                            <li className="note-it note-it-couple">
                                                <div className="image">
                                                    <img src="/Images/seat-couple.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế Đôi</span>
                                            </li>
                                            <li className="note-it">
                                                <div className="image update">
                                                    <img src="/Images/seat-single.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế người khác chọn</span>
                                            </li>
                                            <li className="note-it">
                                                <div className="image choosing">
                                                    <img src="/Images/seat-single.svg" alt="" />
                                                </div>
                                                <span className="txt">Ghế chọn</span>
                                            </li>
                                            <li className="note-it">
                                                <div className="image booked">
                                                    <img src="/Images/seat-single.svg" alt="" />
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
                                    <div className="dt-food-heading sec-heading">
                                        <h2 className="heading">Chọn bắp nước</h2>
                                    </div>
                                    <div className="dt-food-body">
                                        <div className="dt-combo dt-item">
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
                                                                        <img src={`${DOMAIN}/Images/${comboItem.image}`} alt={`${comboItem.image}`} />
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
                                                                            <div className="count-btn count-minus" onClick={() => decrementCombo(comboItem.id)}>
                                                                                <FontAwesomeIcon icon={faMinus} />
                                                                            </div>
                                                                            <p className="count-number">{countCombos[comboItem.id] || 0}</p>
                                                                            <div className="count-btn count-plus" onClick={() => incrementCombo(comboItem.id)}>
                                                                                <FontAwesomeIcon icon={faPlus} />
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
                            <div className="bill-wr">
                                <div className="bill-left">
                                    <h4 className="name-combo">{props.MovieDetail?.name} ({props.MovieDetail?.ageRestrictionName})</h4>
                                    <ul className="list">
                                        <li className="item">
                                            <span className="txt">{selectedheaterName}</span>
                                            {
                                                selectedTicketTypeName && (
                                                    <>
                                                        <span className="dot">|</span>
                                                        <span className="txt">{selectedTicketTypeName}</span>
                                                    </>
                                                )
                                            }
                                        </li>
                                        {
                                            seatYourName && (
                                                <li className="item">
                                                    <span className="txt">Phòng chiếu :</span>
                                                    <span className="txt">{seat?.roomName}</span>
                                                    <span className="dot">|</span>
                                                    <span className="txt">{seatYourName}</span>
                                                    <span className="dot">|</span>
                                                    <span className="dot">{selectedShowTime}</span>
                                                </li>
                                            )
                                        }
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
                                            <span className="num"> {formatCurrency(totalPrice)}</span>
                                        </div>
                                        <button className={`btn btn-warning opacity-100 ticketBooking ${!checkBooking ? 'enableButton' : ''}`}
                                            onClick={() => {
                                                if (checkBooking) {
                                                    const invoiceDTO = new InvoiceDTO();
                                                    invoiceDTO.showTimeId = selectedShowTimeId
                                                    invoiceDTO.roomId = selectedRoomId
                                                    invoiceDTO.theaterId = selectedTheaterId
                                                    invoiceDTO.invoiceTickets = invoiceTickets
                                                    invoiceDTO.foodAndDrinks = Object.entries(countCombos).map((e) => ({ foodAndDrinkId: e[0], quantity: e[1] }))
                                                    console.log(invoiceDTO);
                                                    dispatch(TicketBooking(invoiceDTO))
                                                }
                                            }}
                                            disabled={!checkBooking}

                                        >ĐẶT VÉ</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </>
            )}
            <TicketInfo show={show} handleClose={handleClose} />
        </>
    )
}

export default Theater;