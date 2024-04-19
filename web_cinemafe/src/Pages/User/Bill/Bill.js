import './Bill.css'
const Bill = () => {
    return ( 
        <>
            <div className="dt-bill bill-fixed bill-custom">
                <div className="container">
                    <div className="bill-wr" data-aos="fade-up">
                        <div className="bill-left">
                            <h4 className="name-combo">ĐIỀM BÁO CỦA QUỶ (T18)</h4>
                            <ul className="list">
                                <li className="item">
                                    <span className="txt">Cinestar Quốc Thanh</span>
                                    <span className="dot">|</span>
                                    <span className="txt">2 HSSV-Người Cao Tuổi</span>
                                </li>
                                <li className="item">
                                    <span className="txt">Phòng chiếu :</span>
                                    <span className="txt">04</span>
                                    <span className="dot">|</span>
                                    <span className="txt">A08, A09</span>
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
                                        04: 49{" "}
                                    </span>
                                </div>
                            </div>
                            <div className="bill-right">
                                <div className="price">
                                    <span className="txt">Tạm tính </span>
                                    <span className="num">90,000 đ</span>
                                </div>
                                <button className="btn btn--pri  opacity-100">ĐẶT VÉ</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </>
     );
}
 
export default Bill;