import { faTimes } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import './TicketInfo.css'   
import { Button, Col, Container, Modal, Row } from "react-bootstrap";

const TicketInfo = ({ show, handleClose }) => {
    return (
        <Modal show={show} onHide={handleClose} centered>
            <Modal.Header className="modal-header">
                <button type="button" class="modal-btn-close" onClick={handleClose}>
                    <img src="/Images/ic-close-circle.svg" alt=""></img>
                </button>
            </Modal.Header>
            <Modal.Body closeButton>
                <Container>
                    <div className="form-main">
                        <div className="inner-info">
                            <div className="inner-info-row cinestar-br">
                                <p className="tt">Tên phim</p>
                                <p className="ct">LẬT MẶT 7: MỘT ĐIỀU ƯỚC (K)</p>
                            </div>
                        </div>
                        <div className="inner-info">
                            <div className="inner-info-row code">
                                <p className="tt">Mã đặt vé</p>
                                <p className="ct">115276440</p>
                            </div>
                            <div className="inner-info-row time-line">
                                <p className="tt">Thời gian</p>
                                <p className="ct">
                                    <span className="time">00:15 </span>
                                    <span className="date">06/05/2024</span>
                                </p>
                            </div>
                        </div>
                        <div className="inner-info">
                            <div className="inner-info-row room">
                                <p className="tt">Phòng chiếu</p>
                                <p className="ct">04</p>
                            </div>
                            <div className="inner-info-row num-ticket">
                                <p className="tt">Số vé</p>
                                <p className="ct">1</p>
                            </div>
                            <div className="inner-info-row type-ticket">
                                <p className="tt">Loại vé</p>
                                <p className="ct">Người Lớn</p>
                            </div>
                        </div>
                        <div className="inner-info">
                            <div className="inner-info-row num-position">
                                <p className="tt">Số ghế</p>
                                <p className="ct">H10</p>
                            </div>
                        </div>
                        <div className="inner-info">
                            <div className="inner-info-row">
                                <p className="tt">Rạp</p>
                                <p className="ct">Cinestar Quốc Thanh</p>
                                <p className="dt">
                                    271 Nguyễn Trãi, Phường Nguyễn Cư Trinh, Quận 1, Thành Phố Hồ Chí Minh
                                </p>
                            </div>
                        </div>
                    </div>
                    <div className="form-footer">
                        <div className="inner-info">
                            <div className="inner-info-row total">
                                <p className="tt">Tổng tiền</p>
                                <p className="ct">45,000 VNĐ</p>
                            </div>
                        </div>
                    </div>
                    <Button className="btn btn--pri btn-save btn-full-width">Tải vé về máy</Button>
                </Container>
            </Modal.Body>
        </Modal>
    );
};

export default TicketInfo;