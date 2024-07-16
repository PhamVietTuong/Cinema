import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { MovieListAction } from "../../../Redux/Actions/CinemasAction";
import { Box, CircularProgress, Grid, Pagination } from "@mui/material";
import Film from "../../../Components/Film/Film";
import TheaterComponent from "../../../Components/Theater/TheaterComponent";
import Slide from "../../../Components/Slide/Slide";

const Special = () => {
    const dispatch = useDispatch();
    const { movieList } = useSelector((state) => state.CinemasReducer);
    const [movieSpecial, setMovieSpecial] = useState([]);
    const [currentPage, setCurrentPage] = useState(1);
    const [loading, setLoading] = useState(true);
    const itemsPerPage = 8;

    useEffect(() => {
        dispatch(MovieListAction()).then(() => setLoading(false));
    }, [dispatch]);

    const {
        resultInfoSearch,
    } = useSelector((state) => state.CinemasReducer);

    useEffect(() => {
        if (movieList && movieList.length > 0) {
            const special = movieList.filter(movie => movie.isSpecial);

            setMovieSpecial(special);
        }
    }, [movieList]);

    const hasMovies = resultInfoSearch?.movies && resultInfoSearch.movies.length > 0;
    const hasTheaters = resultInfoSearch?.theaters && resultInfoSearch.theaters.length > 0;

    const handlePageChange = (event, value) => {
        setCurrentPage(value);
    };

    const paginatedMovies = movieSpecial.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage);
    const pageCount = Math.ceil(movieSpecial.length / itemsPerPage);


    if (loading) {
        return (
            <Box sx={{ textAlign: 'center' }}>
                <CircularProgress />
            </Box>
        );
    }
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
                        <section className="web-movie-slide">
                            <div className="movie-showing ht">
                                <div className="container">
                                    <h1 className="title">PHIM ĐANG CHIẾU</h1>
                                    <Grid container spacing={3}>
                                        {
                                            paginatedMovies.map((item, index) => (
                                                <Grid item xs={6} sm={6} md={4} lg={3} key={`${item.id}-${index}`}>
                                                    <Film movie={item} />
                                                </Grid>
                                            ))
                                        }
                                    </Grid>
                                    <Box mt={4} display="flex" justifyContent="center">
                                        <Pagination
                                            count={pageCount}
                                            page={currentPage}
                                            onChange={handlePageChange}
                                            variant="outlined"
                                            size="large"
                                            style={{ marginTop: '20px', display: 'flex', justifyContent: 'center' }}
                                            color="primary"
                                            className="PaginationMovie"
                                        />
                                    </Box>
                                </div>
                            </div>
                        </section>
                    </>
                )
            }
        </>
     );
}
 
export default Special;