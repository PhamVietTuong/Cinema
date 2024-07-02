import { useDispatch, useSelector } from "react-redux";
import { useEffect } from "react";
import './Home.css'
import Slide from "../../../Components/Slide/Slide";
import { MovieListAction, TheaterListAction } from "../../../Redux/Actions/CinemasAction";
import BookQuickTicket from "../BookQuickTicket/BookQuickTicket";
import { Grid } from "@mui/material";
import TheaterComponent from "../../../Components/Theater/TheaterComponent";

const Home = () => {
    const dispatch = useDispatch();
    const { movieList, theaterList } = useSelector((state) => state.CinemasReducer)

    useEffect(() => {
        dispatch(MovieListAction());
        dispatch(TheaterListAction());
    }, [dispatch]);

    const {
        resultInfoSearch,
    } = useSelector((state) => state.CinemasReducer);

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
                                    <Slide movieList={movieList} />
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