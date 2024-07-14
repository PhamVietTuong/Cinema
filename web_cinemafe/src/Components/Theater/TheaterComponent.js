import { Link } from 'react-router-dom';
import './TheaterComponent.css'
import { Button } from '@mui/material';
import { DOMAIN } from '../../Ustil/Settings/Config';
const TheaterComponent = (props) => {
    return ( 
        <>
            <div className="cinema-rental-custom">
                <div className="cinema-rental-remake-img">
                    <img
                        fetchpriority="high"
                        loading="eager"
                        width={500}
                        height={500}
                        decoding="async"
                        data-nimg={1}
                        className="!top-1/2 !left-1/2"
                        src={`${DOMAIN}/Images/${props.theater.image}`} 
                        alt={`${props.theater.image}`}                        
                        style={{ color: "transparent" }}
                    />
                </div>
                <div className="content-main getHeight">
                    <div className="address-box">
                        <div className="cinema-rental-heading collapseHead">
                            <Link
                                className="link"
                                to={`/book-tickets/${props.theater.id}`}                            >
                                <h4 className="sub-tittle">{props.theater.name}</h4>
                            </Link>
                            <i className="far fa-angle-down" />
                        </div>
                        <div className="cinema-rental-bodys">
                            <div className="cinema-rental-footer">
                                <ul className="list">
                                    <li className="item">
                                        <Link
                                            className="link"
                                            to={`/book-tickets/${props.theater.id}`}                                        >
                                            <span className="ic">
                                                <img src="/Images/ic-branch-room.svg" alt="" />
                                            </span>
                                            <span className="txt">{props.theater.countRoom} phòng chiếu với {props.theater.countSeat} ghế.</span>
                                        </Link>
                                    </li>
                                    <li className="item">
                                        <div
                                            className="link"
                                        >
                                            <span className="ic">
                                                <img src="/Images/ic-branch-map.svg" alt="" />
                                            </span>
                                            <span className="txt">
                                                {props.theater.address}
                                            </span>
                                        </div>
                                    </li>
                                </ul>
                            </div>

                            <Link
                                className="btn btn--pri btn-booking !mt-[4px] !mb-[10px]"
                                to={`/book-tickets/${props.theater.id}`}
                            >
                                Đặt vé
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </>
     );
}
 
export default TheaterComponent;