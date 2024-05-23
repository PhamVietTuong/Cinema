import { useState } from 'react';
import './Seat.css'

const Seat = (props) => {
    const [selectedSeats, setSelectedSeats] = useState([]);

    const getInforSeat = (rowSeatItem) => {

        const seatIndex = selectedSeats.indexOf(rowSeatItem.id);
        if (seatIndex === -1) {
            setSelectedSeats([...selectedSeats, rowSeatItem.id]);
        } else {
            const newSelectedSeats = [...selectedSeats];
            newSelectedSeats.splice(seatIndex, 1);
            setSelectedSeats(newSelectedSeats);
        }
    }
    return (
        <>
            <section className="sec-seat">
                <div className="seat">
                    <div className="container">
                        <div className="seat-wr">
                            <div className="seat-heading sec-heading" data-aos="fade-up">
                                <h2 className="heading">Chọn ghế - {props.seat.roomName} </h2>
                            </div>
                            <div className="seat-indicator-scroll">
                                <div className="seat-block relative --full">
                                    <div className="seat-screen" data-aos="fade-up">
                                        <img src="https://cinestar.com.vn/assets/images/img-screen.png" />
                                        <div className="txt">Màn hình</div>
                                    </div>
                                    <div className="seat-main" data-aos="fade-up">
                                        <div className="minimap-container ">
                                            {/* <div className="minimap" style={{ width: 130, height: 68 }}>
                                                <div
                                                    className="minimap-viewport"
                                                    style={{ width: 130, height: 60, left: 0, top: 0 }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 0
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 5
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 10
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 15
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 20
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 25
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 30
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 36
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 41
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 46
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 18,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 24,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 30,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 35,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 41,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 47,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 53,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 59,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 65,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 71,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 77,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 83,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 89,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 94,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 100,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 106,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 6,
                                                        height: 5,
                                                        left: 112,
                                                        top: 51
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 12,
                                                        height: 5,
                                                        left: 6,
                                                        top: 56
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 12,
                                                        height: 5,
                                                        left: 18,
                                                        top: 56
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 12,
                                                        height: 5,
                                                        left: 30,
                                                        top: 56
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 12,
                                                        height: 5,
                                                        left: 41,
                                                        top: 56
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 12,
                                                        height: 5,
                                                        left: 94,
                                                        top: 56
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 12,
                                                        height: 5,
                                                        left: 106,
                                                        top: 56
                                                    }}
                                                />
                                                <div
                                                    className="minimap-children"
                                                    style={{
                                                        position: "absolute",
                                                        width: 12,
                                                        height: 5,
                                                        left: 118,
                                                        top: 56
                                                    }}
                                                />
                                            </div> */}
                                            <div>
                                                <div className="seat-table">
                                                    <table className="seat-table-inner">
                                                        <tbody>
                                                            {
                                                                props.seat.rowName?.map((seatItem, seatIndex) => (
                                                                    <tr>
                                                                        <td className="seat-name-row">{seatItem.rowName}</td>
                                                                        {
                                                                            seatItem.rowSeats.map((rowSeatItem, rowSeatIndex) => (
                                                                                rowSeatItem.name
                                                                                    ?
                                                                                    (
                                                                                        <td className="seat-td" onClick={() => getInforSeat(rowSeatItem)}>
                                                                                            <div className={`seat-wr seat-single ${rowSeatItem.isSold ? 'booked' : ''} ${selectedSeats.includes(rowSeatItem.id) ? 'choosing' : ''}`} >
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
                                                                            ))
                                                                        }
                                                                    </tr>
                                                                ))
                                                            }

                                                            {/* <tr>
                                                                <td className="seat-name-row">A</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="https://cinestar.com.vn/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img
                                                                            src="https://cinestar.com.vn/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">A14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">B</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">B14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">C</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">C17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">D</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">D17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">E</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">E01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">E02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">E03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">E04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="https://cinestar.com.vn/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">E13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">E14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">E15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">E16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">E17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">F</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">F01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">F02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">F03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">F04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">F13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">F14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">F15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">F16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">F17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">G</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">G01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">G02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">G03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">G04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">G13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">G14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">G15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">G16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">G17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">H</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">H01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">H02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">H03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">H04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">H13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">H14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">H15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">H16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">H17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">J</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">J01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">J02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">J03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">J04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-vip">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img src="/assets/images/seat-vip.svg" alt="" />
                                                                        <span className="seat-name">J13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">J14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">J15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">J16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">J17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">K</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">K17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">L</td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L07</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L08</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single booked">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L09</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L10</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L11</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L12</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L13</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L14</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L15</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L16</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td">
                                                                    <div className="seat-wr seat-single ">
                                                                        <img
                                                                            src="/assets/images/seat-single.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">L17</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                            </tr>
                                                            <tr>
                                                                <td className="seat-name-row">M</td>
                                                                <td className="seat-td seat-couple">
                                                                    <div className="seat-wr ">
                                                                        <img
                                                                            src="/assets/images/seat-couple.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">M01</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-couple">
                                                                    <div className="seat-wr ">
                                                                        <img
                                                                            src="/assets/images/seat-couple.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">M02</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-couple">
                                                                    <div className="seat-wr ">
                                                                        <img
                                                                            src="/assets/images/seat-couple.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">M03</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-couple">
                                                                    <div className="seat-wr booked">
                                                                        <img
                                                                            src="/assets/images/seat-couple.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">M04</span>
                                                                    </div>
                                                                </td>
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="" />
                                                                <td className="seat-td seat-couple">
                                                                    <div className="seat-wr ">
                                                                        <img
                                                                            src="/assets/images/seat-couple.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">M05</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-couple">
                                                                    <div className="seat-wr ">
                                                                        <img
                                                                            src="/assets/images/seat-couple.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">M06</span>
                                                                    </div>
                                                                </td>
                                                                <td className="seat-td seat-couple">
                                                                    <div className="seat-wr ">
                                                                        <img
                                                                            src="https://cinestar.com.vn/assets/images/seat-couple.svg"
                                                                            alt=""
                                                                        />
                                                                        <span className="seat-name">M07</span>
                                                                    </div>
                                                                </td>
                                                            </tr> */}
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
        </>
    );
}

export default Seat;