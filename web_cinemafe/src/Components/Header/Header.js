import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import './Header.css'
import { faCalendar, faCircleUser } from '@fortawesome/free-regular-svg-icons';
import { faCaretDown, faLocationDot, faMagnifyingGlass, faTicket } from '@fortawesome/free-solid-svg-icons';

const Header = () => {
    return (
        <>
            <header className="hd --second">
                <div className="popup-download-app">
                    <div>
                        <div className="hd-top">
                            <div className="container">
                                <div className="hd-top-wr">
                                    <div className="popup-top-logo">
                                        <img src="/Images/HeaderAndFooter/app-icon.webp" alt="" />
                                        <div className="popup-top-content">
                                            <div className="text" >
                                                <span className="txt">Tải ứng dụng CineStar Cinema.</span>
                                                <span className="txt txt-sub">Tra cứu lịch chiếu và đặt vé siêu nhanh</span>
                                            </div>
                                            <a href="/" className="link">
                                                <span>Mở</span>
                                            </a>
                                        </div>
                                    </div>
                                    <div className="hd-top-close" >
                                        <img src="/Images/HeaderAndFooter/header-ic-close.svg" alt="" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="hd-mid" >
                    <div className="container" >
                        <div className="hd-mid-wr" >
                            <a
                                className="custom-logo-link"
                                aria-label="The logo of Cinestar"
                                href="/"
                            >
                                <img alt="CineStar Logo" src="/Images/HeaderAndFooter/header-logo.webp" />
                            </a>
                            <div className="hd-action" >
                                <a className="btn book-now" href="/movie/">
                                    <FontAwesomeIcon className="icon" icon={faTicket} />
                                    <span className="txt">Đặt Vé Ngay</span>
                                </a>
                                <a className="btn book-food" href="/popcorn-drink/">
                                    <img className="icon" src="/Images/HeaderAndFooter/ic-cor.svg" alt="" />
                                    <span className="txt">Đặt Bắp Nước</span>
                                </a>
                            </div>
                            <div className="hd-mid-right" >
                                <div className="hd-search" >
                                    <div className="hd-search-icon" >
                                        <img src="/Images/HeaderAndFooter/icon-search.svg" alt="" />
                                    </div>
                                    <div className="hd-search-block togglePanel">
                                        <div className="hd-search-form" >
                                            <div>
                                                <div className="hd-search-wr" >
                                                    <input
                                                        className="re-input !bg-white"
                                                        type="text"
                                                        placeholder="Tìm phim, rạp"
                                                    />
                                                    <button
                                                        className="hd-search-form-btn"
                                                        aria-label="Button search"
                                                        type="submit"
                                                    >
                                                        <FontAwesomeIcon icon={faMagnifyingGlass} />
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="search-bg-blur search-bg-blur-no-top" />
                                    </div>
                                </div>
                                <div className="hd-regi" >
                                    <div className="hd-regi-wr" >
                                        <div className="hd-regi-ava" >
                                            <img src="/Images/HeaderAndFooter/ic-header-auth.svg" alt="" />
                                        </div>
                                        <div className="hd-regi-list" >
                                            <a className="link dang-nhap" href="/login/?prevUrl=/">
                                                <FontAwesomeIcon className="icon" icon={faCircleUser} />
                                                Đăng nhập
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div className="hd-lg" >
                                    <div className="lg-action" >
                                        <div className="lg-popup" >
                                            <div className="lg-option" >
                                                <span className="image">
                                                    <img src="/Images/HeaderAndFooter/footer-vietnam.svg" alt="" />
                                                </span>
                                                <span className="txt">VN</span>
                                                <FontAwesomeIcon className="icon" icon={faCaretDown} />
                                            </div>
                                        </div>
                                        <div className="lg-action-popup" >
                                            <div className="lg-option" >
                                                <span className="image">
                                                    <img src="/Images/HeaderAndFooter/footer-america.png" alt="" />
                                                </span>
                                                <span className="txt">ENG</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="hd-bot" >
                    <div className="container" >
                        <div className="hd-bot-wr hd-regi-wr" >
                            <div className="hd-bot-action-wrap" >
                                <div className="hd-regi" >
                                    <div className="--second" >
                                        <span className="hd-bot-loca chon-rap">
                                            <FontAwesomeIcon className="icon" icon={faLocationDot} />
                                            <span className="txt">Chọn rạp</span>
                                        </span>
                                        <div className="hd-regi-list hd-regi-list-custom --second custom-position-left"                              >
                                            <a
                                                className="link"
                                                href="/book-tickets/8f3a5832-8340-4a43-89bc-6653817162f1"
                                            >
                                                Cinestar Quốc Thanh
                                            </a>
                                            <a
                                                className="link"
                                                href="/book-tickets/667c7727-857e-4aac-8aeb-771a8f86cd14"
                                            >
                                                Cinestar Hai Bà Trưng (TP.HCM)
                                            </a>
                                            <a
                                                className="link"
                                                href="/book-tickets/cf13e1ce-2c1f-4c73-8ce5-7ef65472db3c"
                                            >
                                                Cinestar Sinh Viên (Bình Dương)
                                            </a>
                                            <a
                                                className="link"
                                                href="/book-tickets/8f54df74-3796-42ea-896e-cd638eec1fe3"
                                            >
                                                Cinestar Mỹ Tho
                                            </a>
                                            <a
                                                className="link"
                                                href="/book-tickets/4a51b9ee-f143-4411-9dbb-5f54a1c382c0"
                                            >
                                                Cinestar Kiên Giang
                                            </a>
                                            <a
                                                className="link"
                                                href="/book-tickets/104509be-034e-47c1-bf1b-aba7f2df4f28"
                                            >
                                                Cinestar Lâm Đồng
                                            </a>
                                            <a
                                                className="link"
                                                href="/book-tickets/e08f986a-1937-419e-b1b1-759b7c74728b"
                                            >
                                                Cinestar Đà Lạt
                                            </a>
                                            <a
                                                className="link"
                                                href="/book-tickets/f8a60463-5c34-49a9-9ae8-52081e387bb8"
                                            >
                                                Cinestar Huế
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div className="hd-bot-action-left" >
                                    <a className="hd-bot-loca lich-chieu" href="/showtimes/">
                                        <FontAwesomeIcon className="icon" icon={faCalendar} />
                                        <span className="txt">Lịch chiếu</span>
                                    </a>
                                </div>
                            </div>
                            <div className="hd-bot-km" >
                                <a className="link km" href="/chuong-trinh-khuyen-mai/">
                                    Khuyến mãi
                                </a>
                                <a className="link tsk" href="/to-chuc-su-kien/">
                                    Thuê sự kiện
                                </a>
                                <a className="link tcgt" href="/cac-loai-hinh-giai-tri-khac/">
                                    Tất cả các giải trí
                                </a>
                                <a className="link gt" href="/about-us/">
                                    Giới thiệu
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
        </>
    );
}

export default Header;