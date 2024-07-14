import { faTimes } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import './TicketInfo.css'   
import { Button, Col, Container, Modal, Row } from "react-bootstrap";
import { GetInvoiceAction } from "../../Redux/Actions/CinemasAction";
import { useDispatch, useSelector } from "react-redux";
import { useEffect } from "react";
import moment from "moment";

const formatDate = (dateString) => {
    if (!dateString) return "";
    const formattedDate = moment(dateString).locale("vi").format("dddd DD/MM/yyyy");
    return formattedDate.charAt(0).toUpperCase() + formattedDate.slice(1);
};

const formatCurrency = (value) => {
    if (!value) return 0;
    return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
};

const TicketInfo = ({ show, handleClose, row }) => {
    const dispatch = useDispatch();
    const { invoiceByCode } = useSelector((state) => state.CinemasReducer)

    useEffect(() => {
        if(row.code) {
            dispatch(GetInvoiceAction(row.code));
        }
    }, [row.code]);
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
                                <p className="ct">{invoiceByCode.movieName}</p>
                            </div>
                        </div>
                        <div className="inner-info">
                            <div className="inner-info-row code">
                                <p className="tt">Mã đặt vé</p>
                                <p className="ct">{invoiceByCode.code}</p>
                            </div>
                            <div className="inner-info-row time-line">
                                <p className="tt">Thời gian</p>
                                <p className="ct">
                                    <span className="time">{moment(invoiceByCode?.showTimeStartTime).format("HH:mm")} </span>
                                    <span className="date">{formatDate(invoiceByCode.showTimeStartTime)}</span>
                                </p>
                            </div>
                        </div>
                        <div className="inner-info">
                            <div className="inner-info-row room">
                                <p className="tt">Phòng chiếu</p>
                                <p className="ct">{invoiceByCode.roomName}</p>
                            </div>
                            <div className="inner-info-row num-ticket">
                                <p className="tt">Số vé</p>
                                <p className="ct">{invoiceByCode.numberTicket}</p>
                            </div>
                            <div className="inner-info-row type-ticket">
                                <p className="tt">Loại vé</p>
                                <p className="ct">{invoiceByCode.ticketType}</p>
                            </div>
                        </div>
                        <div className="inner-info">
                            <div className="inner-info-row num-position">
                                <p className="tt">Số ghế</p>
                                <p className="ct">{invoiceByCode.seatName}</p>
                            </div>
                        </div>
                        <div className="inner-info">
                            <div className="inner-info-row">
                                <p className="tt">Rạp</p>
                                <p className="ct">{invoiceByCode.theaterName}</p>
                                <p className="dt">
                                {invoiceByCode.theaterAddress}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div className="form-footer">
                        <div className="inner-info">
                            <div className="inner-info-row total">
                                <p className="tt">Tổng tiền</p>
                                <p className="ct">{formatCurrency(row.totalPrice)}</p>
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