import { useDispatch, useSelector } from "react-redux";
import { useEffect, useState } from "react";
import './Home.css'
import Slide from "../../../Components/Slide/Slide";
import { MovieListAction, TheaterListAction } from "../../../Redux/Actions/CinemasAction";
import BookQuickTicket from "../BookQuickTicket/BookQuickTicket";
import { Grid } from "@mui/material";
import TheaterComponent from "../../../Components/Theater/TheaterComponent";
import { Link } from "react-router-dom";
import { Button } from "react-bootstrap";
import moment from "moment";

const Home = () => {
    const dispatch = useDispatch();
    const { movieList, theaterList, resultInfoSearch } = useSelector((state) => state.CinemasReducer)

    const [movieShowing, setMovieShowing] = useState([]);
    const [movieCooming, setMovieCooming] = useState([]);

    useEffect(() => {
        dispatch(MovieListAction());
        dispatch(TheaterListAction());
    }, [dispatch]);

    useEffect(() => {
        if (movieList && movieList.length > 0) {
            const today = moment();
            const showing = movieList.filter(movie => moment(movie.releaseDate).isBefore(today));
            const cooming = movieList.filter(movie => moment(movie.releaseDate).isAfter(today));

            setMovieShowing(showing);
            setMovieCooming(cooming);
        }
    }, [movieList]);

    const hasMovies = resultInfoSearch?.movies && resultInfoSearch.movies.length > 0;
    const hasTheaters = resultInfoSearch?.theaters && resultInfoSearch.theaters.length > 0;

    return (
        <>
            {
                resultInfoSearch.length !== 0 ? (
                    <>
                        {
                            hasMovies && (
                                <section className="web-movie-slide">
                                    <div className="movie-showing ht">
                                        <div className="container">
                                            <Slide movieList={resultInfoSearch.movies} />
                                        </div>
                                    </div>
                                </section>
                            )
                        }
                        {
                            hasTheaters && (
                                <div className="booking-cinestar-wr">
                                    <div className="cinema-rental-list row cinema-rental-remake collapseBlockJS">
                                        <div className="container">
                                            <Grid container spacing={2}>
                                                {
                                                    resultInfoSearch?.theaters.map(item => (
                                                        <Grid item xs={4}>
                                                            <TheaterComponent theater={item}></TheaterComponent>
                                                        </Grid>
                                                    ))
                                                }
                                            </Grid>
                                        </div>

                                    </div>
                                </div>
                            )
                        }
                    </>
                ) : (
                    <>
                        <BookQuickTicket theaterList={theaterList}></BookQuickTicket >
                        <section className="web-movie-slide">
                            <div className="movie-showing ht">
                                <div className="container">
                                    <h1 className="title">PHIM ĐANG CHIẾU</h1>
                                    <Slide movieList={movieShowing} />
                                    <div className="text-center">
                                        <Link to="/showing">
                                            <Button className="see-more">XEM THÊM</Button>
                                        </Link>
                                    </div>
                                </div>
                            </div>
                            <div className="movie-cooming ht">
                                <div className="container">
                                    <h1 className="title">PHIM SẮP CHIẾU</h1>
                                    <Slide movieList={movieCooming} />
                                    <div className="text-center">
                                        <Link to="/cooming">
                                            <Button className="see-more">XEM THÊM</Button>
                                        </Link>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </>
                )
            }

        </>
    );
}

export default Home;