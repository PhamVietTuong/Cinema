import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import 'swiper/css/pagination';
import 'swiper/css/navigation';
import { Pagination, Navigation } from 'swiper/modules';
import './Film.css'
import { Button } from 'react-bootstrap';
import { DOMAIN } from '../../Ustil/Settings/Config';
import { Link } from 'react-router-dom';
import { ProjectionForm } from '../../Enum/ProjectionForm';

const Film = (props) => {
    return (
        <>
            <div className='web-movie-content'>
                <div className='web-movie-list'>
                    <div className='swiper-container'>
                        <Swiper
                            slidesPerView={4}
                            spaceBetween={30}
                            pagination={{
                                clickable: true,
                            }}
                            navigation={true}
                            modules={[Pagination, Navigation]}
                            className="mySwiper"
                        >
                            {
                                props.movieList.map((item) => {
                                    return (
                                        < SwiperSlide >
                                            <div className="web-movie-box">
                                                <div className="image">
                                                    <Link to={`detail/${item.id}`} state={{ projectionForm: item.projectionForm }}>
                                                        <img src={`${DOMAIN}/Images/${item.image}`} />
                                                        <div className="attach">
                                                            <div className="type-movie">
                                                                { item.projectionForm === ProjectionForm.Time2D ? <span className="txt">2D</span> : <span className="txt">3D</span> }
                                                            </div>
                                                            <div className="age">
                                                                <span className="number">
                                                                    {item.ageRestrictionName}
                                                                </span>
                                                                <span className="txt">
                                                                    {item.ageRestrictionAbbreviation ? item.ageRestrictionAbbreviation.toUpperCase() : ''}
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </Link>
                                                </div>

                                                <div className="info">
                                                    <Link className='name' to={`detail/${item.id}`} state={{ projectionForm: item.projectionForm }}>
                                                        {item.name}
                                                    </Link>

                                                    <div className="info-action">
                                                        <Link className='video pointer' to={item.trailer}>
                                                            <span className="ic">
                                                                <img src="https://cinestar.com.vn/assets/images/icon-play-vid.svg"></img>
                                                            </span>
                                                            <span className="txt">
                                                                Xem trailer
                                                            </span>
                                                        </Link>
                                                        <Button variant="warning">ĐẶC VÉ</Button>
                                                    </div>
                                                </div>
                                            </div>
                                        </SwiperSlide>
                                    )
                                })
                            }
                        </Swiper>
                    </div>
                </div>
            </div >
        </>
    );
}

export default Film;