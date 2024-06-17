import { useDispatch, useSelector } from "react-redux";
import { useEffect } from "react";
import './Home.css'
import Slide from "../../../Components/Slide/Slide";
import { MovieListAction, TheaterListAction } from "../../../Redux/Actions/CinemasAction";
import BookQuickTicket from "../BookQuickTicket/BookQuickTicket";

const Home = () => {
    const dispatch = useDispatch();
    const { movieList, theaterList } = useSelector((state) => state.CinemasReducer)
    
    useEffect(() => {
        dispatch(MovieListAction());
        dispatch(TheaterListAction());
    }, [dispatch]);
    
    return (
        <>
            <BookQuickTicket theaterList={theaterList}></BookQuickTicket>
            <section className="web-movie-slide">
                <div className="movie-showing ht">
                    <div className="container">
                        <Slide movieList={movieList} />
                    </div>
                </div>
            </section>
        </>
    );
}

export default Home;