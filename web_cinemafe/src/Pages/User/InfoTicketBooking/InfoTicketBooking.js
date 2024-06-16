import './InfoTicketBooking.css'

const InfoTicketBooking = () => {
    return ( 
        <>
            <section className="checkout checkout-success ht">
                <div className="container">
                    <div className="checkout-success-wr">
                        <div className="checkout-success sec-heading" data-aos="fade-up">
                            <h2 className="heading">
                                Chúc mừng bạn thanh toán thành công bằng thẻ quốc tế
                            </h2>
                            <ul className="process">
                                <li className="process-item process-cus active">
                                    {" "}
                                    <a className="link" href="">
                                        <span className="num">1 </span>
                                        <span className="txt">Thông tin khách hàng</span>
                                    </a>
                                </li>
                                <li className="process-item process-cus active">
                                    <a className="link" href="">
                                        <span className="num">2</span>
                                        <span className="txt">Thanh toán</span>
                                    </a>
                                </li>
                                <li className="process-item process-cus active">
                                    {" "}
                                    <a className="link" href="">
                                        <span className="num">3</span>
                                        <span className="txt">Thông tin vé phim </span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div className="checkout-success-content">
                            <div
                                className="checkout-success-main"
                                id="ticketToPrint"
                                data-aos="fade-up"
                            >
                                <div className="checkout-success-heading">
                                    <div className="img-movie">
                                        <div className="image">
                                            <img
                                                src="https://api-website.cinestar.com.vn/media/wysiwyg/Posters/06-2024/gia-tai-cua-ngoai-sneakshow.jpg"
                                                alt=""
                                            />
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
                                                <p className="ct">GIA TÀI CỦA NGOẠI 2D PĐ (T13)</p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row">
                                                <p className="tt">
                                                    Phim dành cho khán giả từ đủ 13 tuổi trở lên.
                                                </p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row">
                                                <p className="ct">Cinestar Hai Bà Trưng (TP.HCM)</p>
                                                <p className="dt" />
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row code">
                                                <p className="tt">Mã đặt vé</p>
                                                <p className="ct">136978618</p>
                                            </div>
                                            <div className="inner-info-row time-line">
                                                <p className="tt">Thời gian</p>
                                                <p className="ct">
                                                    <span className="time">23:55</span>
                                                    <span className="date"> Thứ Ba, 11/06/2024</span>
                                                </p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row room">
                                                <p className="tt">Phòng chiếu</p>
                                                <p className="ct">03</p>
                                            </div>
                                            <div className="inner-info-row num-ticket">
                                                <p className="tt">Số vé</p>
                                                <p className="ct">1</p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row type-position">
                                                <p className="tt">Loại ghế</p>
                                                <p className="ct">Standard</p>
                                            </div>
                                            <div className="inner-info-row num-position">
                                                <p className="tt">Số ghế</p>
                                                <p className="ct">H11</p>
                                            </div>
                                        </div>
                                        <div className="inner-info">
                                            <div className="inner-info-row corn-drink">
                                                <p className="tt">Bắp nước</p>
                                                <p className="ct">1 Combo Party</p>
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