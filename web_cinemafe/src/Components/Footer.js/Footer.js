import './Footer.css'

const Footer = () => {
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
                                        <img src="/Images/HeaderAndFooter/footer-logo.png" alt="" />
                                    </a>
                                    <div className="ft-text">
                                        <p className="txt-deskop">BE HAPPY, BE A STAR</p>
                                        <p className="txt-mobile">BE HAPPY, BE A STAR</p>
                                    </div>
                                    <div className="ft-group-btn">
                                        <a className="btn dat-ve" href="/movie">
                                            <span className="txt">ĐẶT VÉ</span>
                                        </a>
                                        <a className="btn dat-bap-nuoc" href="/popcorn-drink">
                                            <span className="txt">ĐẶT BẮP NƯỚC</span>
                                        </a>
                                    </div>
                                    <div className="ft-menu-mobile">
                                        <ul className="menu-list">
                                            <li className="menu-item">
                                                <a href="/account/account-profile/" className="menu-link">
                                                    Tài khoản
                                                </a>
                                            </li>
                                            <li className="menu-item">
                                                <a href="/loai-hinh-cho-thue-khac" className="menu-link">
                                                    Cho thuê sự kiện
                                                </a>
                                            </li>
                                            <li className="menu-item">
                                                <a href="/cac-loai-hinh-giai-tri-khac" className="menu-link">
                                                    Dịch vụ khác
                                                </a>
                                            </li>
                                            <li className="menu-item">
                                                <a href="/about-us/" className="menu-link">
                                                    Giới thiệu
                                                </a>
                                            </li>
                                            <li className="menu-item">
                                                <a className="menu-link" href="/chinh-sach-bao-mat">
                                                    Chính sách bảo mật
                                                </a>
                                            </li>
                                            <li className="menu-item">
                                                <a href="/news" className="menu-link">
                                                    Tin tức
                                                </a>
                                            </li>
                                            <li className="menu-item">
                                                <a href="/career" className="menu-link">
                                                    Tuyển dụng
                                                </a>
                                            </li>
                                            <li className="menu-item">
                                                <a href="/contact" className="menu-link">
                                                    Liên hệ
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div className="ft-hotline-socials">
                                        <ul className="list">
                                            <li className="item item-fb">
                                                <a
                                                    href="https://www.facebook.com/cinestarcinemasvietnam"
                                                    className="link"
                                                    aria-label="Facebook of Cinestart"
                                                >
                                                    <img src="/assets/images/footer-facebook.svg" alt="" />
                                                </a>
                                            </li>
                                            {/* <li class="item item-ig"><a href="https://www.instagram.com/cine_star/" class="link"> <img
                              src="/assets/images/footer-instagram.svg" alt=""></a></li>
                  <li class="item item-lk">
                      <a class="link"> <img src="/assets/images/footer-linkedIn.svg" alt=""></a></li> */}
                                            <li className="item item-yt">
                                                <a
                                                    className="link"
                                                    href="https://www.youtube.com/@CinestarCinemasVietnam"
                                                    aria-label="Youtube of Cinestar"
                                                >
                                                    <img src="/assets/images/footer-youtube.svg" alt="" />
                                                </a>
                                            </li>
                                            <li className="item item-tt">
                                                <a
                                                    className="link"
                                                    href="https://www.tiktok.com/@cinestar_cinemas?is_from_webapp=1&sender_device=pc"
                                                    aria-label="Tiktok of Cinestar"
                                                >
                                                    <img
                                                        src="https://api-website.cinestar.com.vn/media/wysiwyg/CMSPage/Icon/ic-tittok.svg"
                                                        alt=""
                                                    />
                                                </a>
                                            </li>
                                            <li className="item item-zl">
                                                <a
                                                    className="link"
                                                    href="https://zalo.me/2861828859391058401"
                                                    ria-label="Zalo of Cinestar"
                                                >
                                                    <img src="/assets/images/ic-zl-white.svg" alt="" />
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div className="ft-lg">
                                        <div className="txt">
                                            <p>Ngôn ngữ:</p>
                                        </div>
                                        <div className="lg-action popUpJs" id="lang-footer">
                                            <div className="lg-popup">
                                                <div className="lg-option">
                                                    <span className="image">
                                                        <img src="/assets/images/footer-vietnam.svg" alt="" />
                                                    </span>
                                                    <span className="txt">VN</span>
                                                </div>
                                            </div>
                                            <div className="lg-action-popup popUpOpenJs">
                                                <div className="lg-option">
                                                    <span className="image">
                                                        <img src="/assets/images/footer-america.png" alt="" />
                                                    </span>
                                                    <span className="txt">EN</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {/* <div class="footer-item col col-2">
          <div class="footer-item-top">
              <div class="text">Tài khoản</div>
              <ul class="menu-list">
                  <li class="menu-item"><a class="menu-link" href="/login/?prevUrl=">Đăng nhập</a></li>
                  <li class="menu-item"><a class="menu-link" href="/register">Đăng ký</a></li>
                  <li class="menu-item"><a class="menu-link" href="/membership">Membership</a></li>
              </ul>
          </div>
          <div class="footer-item-bot">
              <div class="text">Xem Phim</div>
              <ul class="menu-list">
                  <li class="menu-item"><a class="menu-link" href="/movie/showing/">Phim đang chiếu</a></li>
                  <li class="menu-item"><a class="menu-link" href="/movie/upcoming/">Phim sắp chiếu</a></li>
                  <li class="menu-item"><a class="menu-link" href="/movie">Suất chiếu đặc biệt</a></li>
              </ul>
          </div>
      </div>
      <div class="footer-item col col-2">
        <div class="footer-item-top">
          <div class="text">Thuê sự kiện</div>
          <ul class="menu-list">
              <li class="menu-item"><a class="menu-link" href="/he-thong-thue-rap/">Thuê rạp</a></li>
              <li class="menu-item"><a class="menu-link" href="/loai-hinh-cho-thue-khac/">Các loại hình cho thuê khác</a>
          </ul>
        </div>
          <div class="footer-item-bot">
              <div class="text">Cinestar</div>
              <ul class="menu-list">
                  <li class="menu-item"><a class="menu-link" href="/about-us">Giới thiệu</a></li>
                  <li class="menu-item"><a class="menu-link" href="/contact">Liên hệ</a></li>
                  <li class="menu-item"><a class="menu-link" href="/career/">Tuyển dụng</a></li>
              </ul>
          </div>
      </div> */}
                                <div className="footer-item col col-4">
                                    <div className="row footer-item-top">
                                        <div className="col-6 col">
                                            <div className="text">
                                                Tài khoản
                                            </div>
                                            <ul className="menu-list">
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/login/?prevUrl=">
                                                        Đăng nhập
                                                    </a>
                                                </li>
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/register">
                                                        Đăng ký
                                                    </a>
                                                </li>
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/membership">
                                                        Membership
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div className="col-6 col">
                                            <div className="text">
                                                Thuê sự kiện
                                            </div>
                                            <ul className="menu-list">
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/he-thong-thue-rap/">
                                                        Thuê rạp
                                                    </a>
                                                </li>
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/loai-hinh-cho-thue-khac/">
                                                        Các loại hình cho thuê khác
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div className="row footer-item-bot">
                                        <div className="col-6 col">
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
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/movie">
                                                        Suất chiếu đặc biệt
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div className="col-6 col">
                                            <div className="text">
                                                Cinestar
                                            </div>
                                            <ul className="menu-list">
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/about-us">
                                                        Giới thiệu
                                                    </a>
                                                </li>
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/contact">
                                                        Liên hệ
                                                    </a>
                                                </li>
                                                <li className="menu-item">
                                                    <a className="menu-link" href="/career/">
                                                        Tuyển dụng
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div className="footer-item col col-2">
                                    <div className="text">
                                        Dịch vụ khác
                                    </div>
                                    <ul className="menu-list">
                                        <li className="menu-item">
                                            <a className="menu-link" href="/Restaurant">
                                                Nhà hàng
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/Kidzone">
                                                Kidzone
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/Bowling">
                                                Bowling
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/billiard">
                                                Billiards
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/gym">
                                                Gym
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/opera">
                                                Nhà hát Opera
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/coffee">
                                                Coffee
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div className="footer-item col col-2">
                                    <div className="text">
                                        Hệ thống rạp
                                    </div>
                                    <ul className="menu-list">
                                        <li className="menu-item">
                                            <a className="menu-link" href="/book-tickets/">
                                                Tất cả hệ thống rạp
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/book-tickets/8f3a5832-8340-4a43-89bc-6653817162f1">
                                                Cinestar Quốc Thanh
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/book-tickets/667c7727-857e-4aac-8aeb-771a8f86cd14"
                                            >
                                                Cinestar Hai Bà Trưng (TP.HCM)
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/book-tickets/cf13e1ce-2c1f-4c73-8ce5-7ef65472db3c">
                                                Cinestar Sinh Viên (Bình Dương)
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/book-tickets/8f54df74-3796-42ea-896e-cd638eec1fe3">
                                                Cinestar Mỹ Tho
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a
                                                className="menu-link"
                                                href="/book-tickets/4a51b9ee-f143-4411-9dbb-5f54a1c382c0"
                                            >
                                                Cinestar Kiên Giang
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/book-tickets/104509be-034e-47c1-bf1b-aba7f2df4f28">
                                                Cinestar Lâm Đồng
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/book-tickets/e08f986a-1937-419e-b1b1-759b7c74728b">
                                                Cinestar Đà Lạt
                                            </a>
                                        </li>
                                        <li className="menu-item">
                                            <a className="menu-link" href="/book-tickets/f8a60463-5c34-49a9-9ae8-52081e387bb8">
                                                Cinestar Huế
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div className="footer-bottom" >
                                <div className="footer-bottom-left" >
                                    © 2023 Cinestar. All rights reserved.
                                </div>
                                <ul className="menu-list">
                                    <li className="menu-item">
                                        <a className="menu-link" href="/chinh-sach-bao-mat">
                                            Chính sách bảo mật
                                        </a>
                                    </li>
                                    <li className="menu-item">
                                        <a className="menu-link" href="/news">
                                            Tin điện ảnh
                                        </a>
                                    </li>
                                    <li className="menu-item">
                                        <a className="menu-link" href="/faqs">
                                            Hỏi và đáp
                                        </a>
                                    </li>
                                    {/* <li class="menu-item"><a class="menu-link" href="/career/">Tuyển dụng</a></li>
          <li class="menu-item"><a class="menu-link" href="/contact">Liên hệ</a></li>
          <li class="menu-item"><a class="menu-link" href="/about-us">Giới thiệu</a></li> */}
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div classname="ft-author" >
                        <div
                            classname="container"
                            style={{
                                /* justifyContent: 'center', */
                                textAlign: "center"
                            }}
                        >
                            <div
                                classname="ft-bct"
                                style={{ width: 143 /* height: 50, */, margin: "12px auto" }}

                            >
                                <a
                                    href="http://online.gov.vn/HomePage/CustomWebsiteDisplay.aspx?DocId=51406"
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
                                    <li>
                                        CÔNG TY CỔ PHẦN GIẢI TRÍ PHÁT HÀNH PHIM – RẠP CHIẾU PHIM NGÔI SAO
                                        <br />
                                        ĐỊA CHỈ: 135 HAI BÀ TRƯNG, PHƯỜNG BẾN NGHÉ, QUẬN 1, TP.HCM
                                    </li>
                                    <li>
                                        GIẤY CNĐKDN SỐ: 0312742744, ĐĂNG KÝ LẦN ĐẦU NGÀY 18/04/2014, ĐĂNG
                                        KÝ THAY ĐỔI LẦN THỨ 2 NGÀY 15/09/2014, CẤP BỞI SỞ KH&amp;ĐT TP.HCM
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