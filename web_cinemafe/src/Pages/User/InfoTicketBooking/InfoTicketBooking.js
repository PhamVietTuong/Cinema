import { useEffect, useState } from 'react';
import './InfoTicketBooking.css'
import { useLocation } from 'react-router-dom';
import moment from 'moment';
import "moment/locale/vi";
import { DOMAIN } from '../../../Ustil/Settings/Config';
import { Box, CircularProgress } from '@mui/material';
import { useDispatch, useSelector } from 'react-redux';
import { GetInvoiceListAction } from '../../../Redux/Actions/CinemasAction';

const formatDate = (dateString) => {
    if (!dateString) return "";
    const formattedDate = moment(dateString).locale("vi").format("dddd DD/MM/yyyy");
    return formattedDate.charAt(0).toUpperCase() + formattedDate.slice(1);
};


const InfoTicketBooking = () => {
    const [movieInfo, setMovieInfo] = useState(null);
    const dispatch = useDispatch();
    const location = useLocation();

    useEffect(() => {
        const fetchData = async () => {
            const params = new URLSearchParams(location.search);
            const result = params.get("result");

            if (result) {
                try {
                    const decodedResult = decodeURIComponent(escape(atob(result)));
                    const decodedJson = JSON.parse(decodedResult);
                    setMovieInfo(decodedJson.movieInfo);
                } catch (error) {
                    console.error("Error decoding JSON:", error);
                }
            }
        };

        fetchData();
    }, [location.search, dispatch]);

    if (!movieInfo) {
        return <Box sx={{ textAlign: 'center' }}>
                    <CircularProgress />
                </Box>;
    }
    return ( 
        <>
            <section className="checkout checkout-success ht">
                <div className="container">
                    <div className="checkout-success-wr">
                        <div className="checkout-success sec-heading">
                            <h2 className="heading">
                                Chúc mừng bạn thanh toán thành công bằng thẻ quốc tế
                            </h2>
                        </div>
                        <div className="checkout-success-content">
                            <div
                                className="checkout-success-main"
                                id="ticketToPrint"
                            >
                                <div className="checkout-success-heading">
                                    <div className="img-movie">
                                        <div className="image">
                                            <img src={`${DOMAIN}/Images/${movieInfo.MovieImage}`} alt={`${movieInfo.MovieImage}`}></img>
                                        </div>
                                    </div>
                                    <div id="myqrcode" className="img-qrcode">
                                        <div
                                            className="ant-qrcode !w-[100%] !h-[100%] !p-[4rem] css-1qhpsh8"
                                            style={{
                                                width: 160,
                                                height: 160,
                                                backgroundColor: "transparent"
                                            }}
                                        >
                                            <canvas height={200} width={200} />
                                        </div>
                                    </div>
                                </div>
                                <div className="form-checkout-cus">
                                    <div className="form-main">
                                        <div className="inner-info">
                                            <div className="inner-info-row">
                                                <p className="ct">{movieInfo?.MovieName} ({movieInfo?.AgeRestrictionName})</p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row">
                                                <p className="tt">
                                                    {movieInfo?.AgeRestrictionDescription}
                                                </p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row">
                                                <p className="ct"> {movieInfo?.TheaterName}</p>
                                                <p className="dt" />
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row code">
                                                <p className="tt">Mã đặt vé</p>
                                                <p className="ct"> {movieInfo?.Code}</p>
                                            </div>
                                            <div className="inner-info-row time-line">
                                                <p className="tt">Thời gian</p>
                                                <p className="ct">
                                                    <span className="time">{moment(movieInfo?.ShowTimeStartTime).format("HH:mm")}</span>
                                                    <span className="date"> {formatDate(movieInfo?.ShowTimeStartTime)}</span>
                                                </p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row room">
                                                <p className="tt">Phòng chiếu</p>
                                                <p className="ct"> {movieInfo?.RoomName}</p>
                                            </div>
                                            <div className="inner-info-row num-ticket">
                                                <p className="tt">Số vé</p>
                                                <p className="ct">{movieInfo?.SeatName?.split(",").length}</p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row type-position">
                                                <p className="tt">Loại ghế</p>
                                                <p className="ct">{movieInfo?.ShowTimeType}</p>
                                            </div>
                                            <div className="inner-info-row num-position">
                                                <p className="tt">Số ghế</p>
                                                <p className="ct">{movieInfo?.SeatName}</p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row corn-drink">
                                                <p className="tt">Bắp nước</p>
                                                {movieInfo?.FoodAndDrinks?.map((item) => (
                                                    <p key={item.name} className="ct">
                                                        {item.Quantity} {item.FoodAndDrinkName}
                                                    </p>
                                                ))}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div className="btn-gr">
                                <button className="btn btn--pri h-[41px]">
                                    Tải vé về máy
                                </button>
                                <div className="btn btn--white !h-[41px]">
                                    Tạo tài khoản thành viên
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </>
     );
}
 
export default InfoTicketBooking;