import { useDispatch, useSelector } from "react-redux";
import { GetNewsListAction } from "../../../Redux/Actions/CinemasAction";
import { useEffect, useState } from "react";
import { Box, Grid, Typography } from "@mui/material";
import './News.css'
import { DOMAIN } from "../../../Ustil/Settings/Config";
const News = () => {
    const dispatch = useDispatch();

    const { listNews } = useSelector((state) => state.CinemasReducer)
    const [news, setNews] = useState([]);

    useEffect(() => {
        if (listNews && listNews.length > 0) {
            setNews(listNews);
        }
    }, [listNews]);

    useEffect(() => {
        dispatch(GetNewsListAction());
    }, [dispatch]);

    return (
        <div className="container">
            <Box className="ci-rental-event-content" py={4}>
                {
                    news && (
                        news.map((item, index) => (
                            <Grid key={index} container spacing={4} className="ci-rental-event-item opera-more-wr" >
                                <Grid item xs={12} md={6} className="opera-more-left" display="flex" justifyContent="space-between" alignItems="center">
                                    <Box className="opera-more-head sec-heading" data-aos="fade-up">
                                        <Box className="heading">
                                            <Typography variant="h2">{item.title}</Typography>
                                        </Box>
                                        <Box className="desc">
                                            <Typography variant="body1" className="txt">
                                                {item.content}
                                            </Typography>
                                        </Box>
                                    </Box>
                                </Grid>
                                <Grid item xs={12} md={6} className="opera-more-right">
                                    <Box className="image" data-aos="fade-up">
                                        <img
                                            src={`${DOMAIN}/Images/${item.image}`} 
                                            alt={`new${index}`}
                                            style={{ width: '100%', height: 'auto' }}
                                        />
                                    </Box>
                                </Grid>
                            </Grid>
                        ))
                    )
                }
            </Box>
        </div>
    );
}

export default News;