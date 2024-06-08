import { useDispatch, useSelector } from "react-redux";
import { useEffect } from "react";
import './Home.css'
import Slide from "../../../Components/Slide/Slide";
import { MovieListAction } from "../../../Redux/Actions/CinemasAction";
import Header from "../../../Components/Header/Header";
import Footer from "../../../Components/Footer.js/Footer";

const Home = () => {
    const dispatch = useDispatch();
    const { movieList } = useSelector((state) => state.CinemasReducer)
    useEffect(() => {
        dispatch(MovieListAction());
    }, [dispatch]);

    return (
        <>
            <Header></Header>
            <div className="main">
                <section className="web-movie-slide">
                    <div className="movie-showing ht">
                        <div className="container">
                            <Slide movieList={movieList} />
                        </div>
                    </div>
                </section>
            </div>
            <Footer></Footer>
        </>
    );
}

export default Home;