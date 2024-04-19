import './SeatType.css'
const SeatType = (props) => {
    return ( 
        <>
            <section className="sec-ticket bill-fixed-start">
                {/* <div className="popup popup-noti  ">
                    <div className="popup-overlay" />
                    <div className="popup-main">
                        <div className="popup-main-wrapper">
                            <div className="popup-over">
                                <div className="popup-wrapper">
                                    <div className="popup-noti-wr">
                                        <p className="popup-noti-des">
                                            Vui lòng chọn tối đa <span className="c-second">8</span> ghế
                                        </p>
                                        <div className="popup-noti-ctr">
                                            <div className="btn btn--outline">
                                                <span className="txt">OK</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="popup-close popupClose">
                            <i className="fas fa-times icon" />
                        </div>
                    </div>
                </div> */}
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
                                                props.ticketType.map((ticketItem, ticketIndex) => (
                                                    <div className="combo-item col col-4">
                                                        <div className="food-box">
                                                            <div className="content">
                                                                <div className="content-top">
                                                                    <p className="name sub-title cursor-pointer">
                                                                        {ticketItem.name}
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
                                            
                                            {/* <div className="combo-item col col-4">
                                                <div className="food-box">
                                                    <div className="content">
                                                        <div className="content-top">
                                                            <p className="name sub-title cursor-pointer">
                                                                HSSV-Người Cao Tuổi
                                                            </p>
                                                            <div className="desc">
                                                                <p>ĐƠN</p>
                                                            </div>
                                                            <div className="price sub-title">
                                                                <p>45,000</p>
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
                                            <div className="combo-item col col-4">
                                                <div className="food-box">
                                                    <div className="content">
                                                        <div className="content-top">
                                                            <p className="name sub-title cursor-pointer">
                                                                Người Lớn
                                                            </p>
                                                            <div className="desc">
                                                                <p>ĐÔI</p>
                                                            </div>
                                                            <div className="price sub-title">
                                                                <p>145,000</p>
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
                                            </div> */}
                                        </div>
                                    </div>
                                </div>
                                {/* <div className="ticket-ft">
                                    {" "}
                                    <span className="dot">*</span>
                                    <span className="txt">
                                        Lưu ý: Mang CCCD hoặc thẻ HSSV khi đến rạp
                                    </span>
                                </div> */}
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </>
     );
}
 
export default SeatType;