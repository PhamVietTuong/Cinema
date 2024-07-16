import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import './Header.css';
import { faCalendar, faCircleUser } from '@fortawesome/free-regular-svg-icons';
import { faCaretDown, faLocationDot, faMagnifyingGlass, faSignOutAlt, faTicket, faUser } from '@fortawesome/free-solid-svg-icons';
import { Link } from 'react-router-dom';
import { useEffect, useRef, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { LOGOUT } from '../../Redux/Actions/Type/UserType';
import { useDebounce } from 'use-debounce';
import { SearchByNameAction, TheaterListAction } from '../../Redux/Actions/CinemasAction';
import { AddSearchHistoryAction, RemoveSearchHistoryAction } from '../../Redux/Actions/UsersAction';

const Header = (props) => {
    const dispatch = useDispatch();
    const { loginInfo, searchHistory } = useSelector((state) => state.UserReducer);

    const [infoSearch, setInfoSearch] = useState('');
    const [isSearchVisible, setIsSearchVisible] = useState(false);
    const searchRef = useRef(null);

    useEffect(() => {
        const handleClickOutside = (event) => {
            if (searchRef.current && !searchRef.current.contains(event.target)) {
                setIsSearchVisible(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => {
            document.removeEventListener('mousedown', handleClickOutside);
        };
    }, [searchRef]);

    const handleSearchClick = () => {
        setIsSearchVisible(true);
    };

    const handleSuggestionClick = (term) => {
        setInfoSearch(term);
        setIsSearchVisible(false);
        dispatch(SearchByNameAction(term));
    };

    const handleSearch = () => {
        if(infoSearch) {
            dispatch(SearchByNameAction(infoSearch));
            dispatch(AddSearchHistoryAction(infoSearch));
        }
    };

    const handleRemoveSearchTerm = (term) => {
        dispatch(RemoveSearchHistoryAction(term));
    };

    return (
        <>
            <header className="hd --second">
                {/* <div className="popup-download-app">
                    <div>
                        <div className="hd-top">
                            <div className="container">
                                <div className="hd-top-wr">
                                    <div className="popup-top-logo">
                                        <img src="/Images/logo.png" alt="" />
                                        <div className="popup-top-content">
                                            <div className="text">
                                                <span className="txt">Tải ứng dụng CineStar Cinema.</span>
                                                <span className="txt txt-sub">Tra cứu lịch chiếu và đặt vé siêu nhanh</span>
                                            </div>
                                            <a href="/" className="link">
                                                <span>Mở</span>
                                            </a>
                                        </div>
                                    </div>
                                    <div className="hd-top-close">
                                        <img src="/Images/HeaderAndFooter/header-ic-close.svg" alt="" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                */}
                <div className="hd-mid">
                    <div className="container">
                        <div className="hd-mid-wr">
                            <a className="custom-logo-link" aria-label="The logo of Cinestar" href="/">
                                <img alt="CineStar Logo" src="/Images/logo.png" />
                            </a>
                            <div className="hd-action">
                                {/* <a className="btn book-food btn--second" href="/popcorn-drink/">
                                    <img className="icon" src="/Images/HeaderAndFooter/ic-cor.svg" alt="" />
                                    <span className="txt">Đặt Bắp Nước</span>
                                </a> */}
                            </div>
                            <div className="hd-mid-right">
                                <div className="hd-search" ref={searchRef}>
                                    <div className="hd-search-icon">
                                        <img src="/Images/HeaderAndFooter/icon-search.svg" alt="" />
                                    </div>
                                    <div className="hd-search-block togglePanel">
                                        <div className="hd-search-form" onClick={handleSearchClick}>
                                            <div>
                                                <div className="hd-search-wr">
                                                    <input
                                                        className="re-input !bg-white"
                                                        type="text"
                                                        placeholder="Tìm phim, rạp"
                                                        value={infoSearch}
                                                        onChange={(e) => setInfoSearch(e.target.value)}
                                                    />
                                                    <button
                                                        className="hd-search-form-btn"
                                                        aria-label="Button search"
                                                        onClick={handleSearch}
                                                    >
                                                        <FontAwesomeIcon icon={faMagnifyingGlass} />
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        {isSearchVisible && (
                                            <div className="search-history">
                                                {searchHistory.map((term, index) => (
                                                    <div key={index} className="search-term-container">

                                                    <div
                                                        key={index}
                                                        className="search-term"
                                                        onClick={() => handleSuggestionClick(term)}
                                                    >
                                                        {term}
                                                    </div>
                                                    <button
                                                            className="remove-search-term-btn"
                                                            onClick={() => handleRemoveSearchTerm(term)}
                                                        >
                                                            &times;
                                                        </button>
                                                    </div>

                                                ))}
                                            </div>
                                        )}
                                        <div className="search-bg-blur search-bg-blur-no-top" />
                                    </div>
                                </div>
                                <div className="hd-regi">
                                    <div className="hd-regi-wr">
                                        <div className="hd-regi-ava">
                                            <Link to={`/login`}>
                                                <img src="/Images/HeaderAndFooter/ic-header-auth.svg" alt="" />
                                            </Link>
                                        </div>
                                        {loginInfo && Object.keys(loginInfo).length !== 0 ? (
                                            <>
                                                <span className="hd-regi-name">{loginInfo?.fullName}</span>
                                                <div className="hd-regi-list --second">
                                                    <Link to="account/account-profile/" className="link" href="">
                                                        <FontAwesomeIcon icon={faUser} />
                                                        Thông tin cá nhân
                                                    </Link>
                                                    {loginInfo.type === 'admin' && (
                                                        <Link to="/admin/revenue" className="link" href="">
                                                            <FontAwesomeIcon icon={faUser} />
                                                            Quản trị viên
                                                        </Link>
                                                    )}
                                                    <span className="dot">/</span>
                                                    <span
                                                        className="link"
                                                        onClick={() => {
                                                            dispatch({
                                                                type: LOGOUT,
                                                            });
                                                        }}
                                                    >
                                                        <FontAwesomeIcon icon={faSignOutAlt} />
                                                        Đăng xuất
                                                    </span>
                                                </div>
                                            </>
                                        ) : (
                                            <div className="hd-regi-list">
                                                <Link to={`/login`} className="link dang-nhap">
                                                    Đăng nhập
                                                </Link>
                                            </div>
                                        )}
                                    </div>
                                </div>
                                {/* <div className="hd-lg">
                                    <div className="lg-action">
                                        <div className="lg-popup">
                                            <div className="lg-option">
                                                <span className="image">
                                                    <img src="/Images/HeaderAndFooter/footer-vietnam.svg" alt="" />
                                                </span>
                                                <span className="txt">VN</span>
                                                <FontAwesomeIcon className="icon" icon={faCaretDown} />
                                            </div>
                                        </div>
                                        <div className="lg-action-popup">
                                            <div className="lg-option">
                                                <span className="image">
                                                    <img src="/Images/HeaderAndFooter/footer-america.png" alt="" />
                                                </span>
                                                <span className="txt">ENG</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>  */}
                            </div>
                        </div>
                    </div>
                </div>
                <div className="hd-bot">
                    <div className="container">
                        <div className="hd-bot-wr hd-regi-wr">
                            <div className="hd-bot-action-wrap">
                                <div className="hd-regi">
                                    <div className="--second">
                                        <span className="hd-bot-loca chon-rap">
                                            <FontAwesomeIcon className="icon" icon={faLocationDot} />
                                            <span className="txt">Chi nhánh</span>
                                        </span>
                                        <div className="hd-regi-list hd-regi-list-custom --second custom-position-left">
                                            {props.theaterList.length > 0 &&
                                                props.theaterList.map((item) => (
                                                    <Link to={`book-tickets/${item.id}`} className="link">
                                                        {item.name}
                                                    </Link>
                                                ))}
                                        </div>
                                    </div>
                                </div>
                                {/* <div className="hd-bot-action-left">
                                    <a className="hd-bot-loca lich-chieu" href="/showtimes/">
                                        <FontAwesomeIcon className="icon" icon={faCalendar} />
                                        <span className="txt">Lịch chiếu</span>
                                    </a>
                                </div> */}
                            </div>
                            <div className="hd-bot-km">
                                {/* <a className="link km" href="/chuong-trinh-khuyen-mai/">
                                    Khuyến mãi
                                </a>  */}
                                <a className="link news" href="/news">
                                    Tin tức
                                </a>
                                <a className="link about-us" href="/about-us">
                                    Giới thiệu
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
        </>
    );
};

export default Header;
