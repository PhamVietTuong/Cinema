import { Link, useLocation, useParams } from 'react-router-dom';
import { useDispatch, useSelector } from "react-redux";
import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import 'swiper/css/pagination';
import './Detail.css'   
import { Pagination } from 'swiper/modules';
import Theater from '../Theater/Theater';
import { useEffect } from 'react';
import { MovieDetailAction } from '../../../Redux/Actions/CinemasAction';
import { DOMAIN } from '../../../Ustil/Settings/Config';
import moment from 'moment';
import { MovieDetailDTO } from '../../../Models/MovieDetailDTO';
const Detail = () => {
    const dispatch = useDispatch();
    let { id } = useParams();
    const { movieDetail } = useSelector((state) => state.CinemasReducer)
    let location = useLocation();
    let projectionForm = location.state?.projectionForm; 

    useEffect(() => {
        let movieDetailDTO = new MovieDetailDTO();
        movieDetailDTO.id = id;
        movieDetailDTO.projectionForm = projectionForm

        dispatch(MovieDetailAction(movieDetailDTO))
    }, [dispatch, id, projectionForm]);

    return (
        <>
        <main className='app-main'>
                <div className="app-content">
                    <section className="sec-detail">
                        <div className="detail ht">
                            <div className="container">
                                <div className="detail-wr">
                                    <div className="detail-row row">
                                        <div className='detail-left col col-5'>
                                            <div class="web-movie-box">
                                                <div className="web-movie-box">
                                                    <div className="image">
                                                        <img src={`${DOMAIN}/Images/${movieDetail?.image}`} alt=""></img>
                                                        <div className="attach">
                                                            <div className="type-movie">
                                                                <span className="txt">{movieDetail?.showTimeTypeName}</span>
                                                            </div>
                                                            <div className="age">
                                                                <span className="number">
                                                                    {movieDetail?.ageRestrictionName}
                                                                </span>
                                                                <span className="txt">
                                                                    {movieDetail?.ageRestrictionAbbreviation ? movieDetail?.ageRestrictionAbbreviation.toUpperCase() : ''}
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className='detail-right col col-7'>
                                            <div className='detail-ct'>
                                                <div className='detail-ct-h'>
                                                    <h1 className='heading'>
                                                        {movieDetail?.name} ({movieDetail?.ageRestrictionName})
                                                    </h1>
                                                    <ul className='info-detail'>
                                                        <li className='info-item'>
                                                            <span class="ic">
                                                                <img src="https://cinestar.com.vn/assets/images/icon-tag.svg" alt="" />
                                                            </span>
                                                            <span class="txt">{movieDetail?.movieType}</span>
                                                        </li>
                                                        <li className='info-item'>
                                                            <span class="ic">
                                                                <img src="https://cinestar.com.vn/assets/images/icon-clock.svg" alt="" />
                                                            </span>
                                                            <span class="txt">{movieDetail?.time}'</span>
                                                        </li>
                                                        <li className='info-item'>
                                                            <span class="ic">
                                                                <i class="fa-regular fa-earth-americas fa-lg " style={{ color: "#ede12d", fontSize: "2.1rem" }}></i>
                                                            </span>
                                                            <span class="txt">Khác</span>
                                                        </li>
                                                        <li className='info-item'>
                                                            <span class="ic"><i class="fa-regular fa-user-check" style={{ color: "#ede12d" }}></i></span>
                                                            <span class="txt">{movieDetail?.ageRestrictionName}: {movieDetail?.ageRestrictionDescription}</span>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div className='detail-ct-bd'>
                                                    <h3 className='tt sub-tittle'>
                                                        Mô tả
                                                    </h3>
                                                    <ul className='font-family-actor'>
                                                        <li>Đạo diễn: {movieDetail?.director}</li>
                                                        <li>Diễn viên: {movieDetail?.actor}</li>
                                                        <li>Khởi chiếu: {moment(movieDetail?.releaseDate).format("DD/MM/YYYY")}</li>
                                                    </ul>
                                                </div>
                                                <div className='detail-ct-bd'>
                                                    <h3 className='tt sub-tittle'>
                                                        Nội dung phim
                                                    </h3>
                                                    <div className='ct'>
                                                        <div className='dt'>
                                                            <p class="txt line-clamp-6 description">{movieDetail?.description}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className='detail-ct-ft'>
                                                    <div class="video pointer">
                                                        <span class="ic">
                                                            <img src="https://cinestar.com.vn/assets/images/icon-play-vid.svg"></img>
                                                        </span>
                                                        <span class="txt">Xem Trailer</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <Theater MovieDetail={movieDetail}></Theater>
                </div>
        </main>
        </>
    );
}

export default Detail;