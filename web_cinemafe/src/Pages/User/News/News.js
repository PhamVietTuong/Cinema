import { useDispatch, useSelector } from "react-redux";

const News = () => {
    const dispatch = useDispatch();

    const { theaterList } = useSelector((state) => state.CinemasReducer)
    
    useEffect(() => {
        dispatch(TheaterListAction());
    }, [dispatch]);

    return (
        <>
            
        </>
    );
}

export default News;