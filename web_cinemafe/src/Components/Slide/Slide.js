import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import 'swiper/css/pagination';
import 'swiper/css/navigation';
import { Pagination, Navigation } from 'swiper/modules';
import './Slide.css';
import Film from '../Film/Film';
import { useEffect, useState } from 'react';

const Slide = (props) => {
    const [showTrailerPopup, setShowTrailerPopup] = useState({ status: false, id: null });

    const selectedMovie = props.movieList.find(movie => movie.id === showTrailerPopup.id);
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
                            breakpoints={{
                                375: { 
                                    slidesPerView: 2,
                                    spaceBetween: 15
                                },
                                768: {
                                    slidesPerView: 4,
                                    spaceBetween: 30
                                }
                            }}
                        >
                            {
                                props.movieList.map((item) => {
                                    return (
                                        <SwiperSlide key={item.id}>
                                            <Film movie={item} setShowTrailerPopup={setShowTrailerPopup}></Film>
                                        </SwiperSlide>
                                    )
                                })
                            }
                        </Swiper>
                    </div>
                </div>
            </div>
            {
                showTrailerPopup.status && (
                    
                    <div className={`modalDetail ${showTrailerPopup.status ? 'enter-done' : ''}`} onClick={() => setShowTrailerPopup({ status: false, id: null })} >
                            <iframe
                                style={{ position: "relative" }}
                                title="title4"
                                allowFullScreen
                                width="996px"
                                height="500px"
                                src={`https://www.youtube.com/embed/${selectedMovie.trailer}`}
                                frameBorder="0"
                            ></iframe>
                        </div>
                )
            }
        </>
    );
}

export default Slide;
