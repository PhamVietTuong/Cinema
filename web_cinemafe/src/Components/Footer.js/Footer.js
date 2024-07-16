import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import './Footer.css'
import { faFacebook, faTiktok, faYoutube } from '@fortawesome/free-brands-svg-icons';
import { useDispatch, useSelector } from 'react-redux';
import { useEffect } from 'react';
import { TheaterListAction } from '../../Redux/Actions/CinemasAction';

const Footer = () => {
    const dispatch = useDispatch();
    const { theaterList } = useSelector((state) => state.CinemasReducer)
    useEffect(() => {
        dispatch(TheaterListAction());
    }, [dispatch]);

    return (
        <>
            <div className="footer">
                <div>
                    <div className="container">
                        <div className="footer-wr">
                            <div className="footer-top-mobile">
                                &nbsp;
                            </div>
                            <div className="footer-list row">
                                <div className="footer-item col col-4">
                                    <a href="/" className="ft-logo" aria-label="The logo of Cinestar">
                                        <img src="/Images/logo.png" alt="" />
                                    </a>
                                    <div className="ft-group-btn">
                                        {/* <a className="btn dat-ve" href="/">
                                            <span className="txt">ĐẶT VÉ</span>
                                        </a>
                                        <a className="btn dat-bap-nuoc" href="/popcorn-drink">
                                            <span className="txt">ĐẶT BẮP NƯỚC</span>
                                        </a> */}
                                    </div>
                                    <div className="ft-hotline-socials">
                                        <ul className="list">
                                            <li className="item item-fb">
                                                <a
                                                    href="/"
                                                    className="link"
                                                    aria-label="Facebook of Cinestart"
                                                >
                                                    <FontAwesomeIcon className="icon" icon={faFacebook} />
                                                </a>
                                            </li>
                                            <li className="item item-yt">
                                                <a
                                                    className="link"
                                                    href="/"
                                                    aria-label="Youtube of Cinestar"
                                                >
                                                    <FontAwesomeIcon className="icon" icon={faYoutube} />
                                                </a>
                                            </li>
                                            <li className="item item-tt">
                                                <a
                                                    className="link"
                                                    href="/"
                                                    aria-label="Tiktok of Cinestar"
                                                >
                                                    <FontAwesomeIcon className="icon" icon={faTiktok} />
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    {/* <div className="ft-lg">
                                        <div className="txt">
                                            <p>Ngôn ngữ:</p>
                                        </div>
                                        <div className="lg-action popUpJs" id="lang-footer">
                                            <div className="lg-popup">
                                                <div className="lg-option">
                                                    <span className="image">
                                                        <img src="/Images/HeaderAndFooter/footer-vietnam.svg" alt="" />
                                                    </span>
                                                    <span className="txt">VN</span>
                                                </div>
                                            </div>
                                            <div className="lg-action-popup popUpOpenJs">
                                                <div className="lg-option">
                                                    <span className="image">
                                                        <img src="/Images/HeaderAndFooter/footer-america.png" alt="" />
                                                    </span>
                                                    <span className="txt">EN</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div> */}
                                </div>
                                <div className="footer-item col col-2">
                                    <div className="text">
                                        Tài khoản
                                    </div>
                                    <ul className="menu-list">
                                        <li className="menu-item">
                                            <a className="menu-link" href="/login">
                                                Đăng nhập
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/login">
                                                Đăng ký
                                            </a>
                                        </li>
                                        {/* <li className="menu-item">
                                            <a className="menu-link" href="/membership">
                                                Membership
                                            </a>
                                        </li> */}
                                    </ul>
                                </div>
                                <div className="footer-item col col-2">
                                    <div className="text">
                                        Xem Phim
                                    </div>
                                    <ul className="menu-list">
                                        <li className="menu-item">
                                            <a className="menu-link" href="/movie/showing/">
                                                Phim đang chiếu
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/movie/upcoming/">
                                                Phim sắp chiếu
                                            </a>
                                        </li>
                                        {/* <li className="menu-item">
                                            <a className="menu-link" href="/movie">
                                                Suất chiếu đặc biệt
                                            </a>
                                        </li> */}
                                    </ul>
                                </div>
                                <div className="footer-item col col-2">
                                    <div className="text">
                                        CKC CINEMA
                                    </div>
                                    <ul className="menu-list">
                                        <li className="menu-item">
                                            <a className="menu-link" href="/about-us">
                                                Giới thiệu
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/news">
                                                Tin tức
                                            </a>
                                        </li>
                                        {/* <li className="menu-item">
                                            <a className="menu-link" href="/movie">
                                                Suất chiếu đặc biệt
                                            </a>
                                        </li> */}
                                    </ul>
                                </div>
                                <div className="footer-item col col-2">
                                    <div className="text">
                                        Hệ thống chi nhánh
                                    </div>
                                    <ul className="menu-list">
                                        {theaterList.map((item, index) => (
                                            <li key={index} className="menu-item">
                                                <a className="menu-link" href={`/book-tickets/${item.id}`}>
                                                    {item.name}
                                                </a>
                                            </li>
                                        ))}
                                    </ul>
                                </div>
                            </div>
                            <div className="footer-bottom" >
                                <div className="footer-bottom-left" >
                                    © 2024 CKC Cinema. All rights reserved.
                                </div>
                                <ul className="menu-list">
                                    <li className="menu-item">
                                        <a className="menu-link" href="/">
                                            Chính sách bảo mật
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div classname="ft-author" >
                        <div classname="container" style={{ textAlign: "center" }}>
                            <div classname="ft-bct" style={{ width: 143, margin: "12px auto" }}>
                                <a
                                    href="http://online.gov.vn"
                                    target="_blank"
                                    aria-label="Ministry of Industry and Trade recognized Cinestar"
                                    bis_size='{"x":694,"y":6655,"w":143,"h":54,"abs_x":694,"abs_y":6655}'
                                >
                                    <img
                                        src="https://api-website.cinestar.com.vn/media/.renditions/wysiwyg/bocongthuong/dathongbao.png"
                                        alt=""
                                        bis_size='{"x":694,"y":6655,"w":143,"h":54,"abs_x":694,"abs_y":6655}'
                                        bis_id="bn_z3eqi1u6t2y6ae9j502zc1"
                                    />
                                </a>
                            </div>
                            <div classname="ft-author-content" style={{ fontSize: 10 }}>
                                <ul>
                                    <li style={{ margin: "0 0 4px 0" }}>
                                        CÔNG TY CỔ PHẦN GIẢI TRÍ PHÁT HÀNH PHIM – RẠP CHIẾU PHIM CKC Cinema
                                    </li>
                                    <li style={{ margin: "0 0 4px 0" }}>
                                        ĐỊA CHỈ: 65 HUỲNH THÚC KHÁNG, PHƯỜNG BẾN NGHÉ, QUẬN 1, TP.HCM
                                    </li>
                                    <li>
                                        GIẤY CNĐKDN SỐ: 88888888888, ĐĂNG KÝ NGÀY 15/06/2024
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Footer;