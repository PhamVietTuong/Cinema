import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import 'swiper/css/pagination';
import 'swiper/css/navigation';
import { Pagination, Navigation } from 'swiper/modules';
import './Slide.css'
import Film from '../Film/Film';

const Slide = (props) => {
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
                                            <Film movie={item}></Film>
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
 
export default Slide;