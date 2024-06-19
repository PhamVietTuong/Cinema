import { Outlet } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { useEffect } from "react";
import { TheaterListAction } from "../../Redux/Actions/CinemasAction";
import Header from "../../Components/Header/Header";
import Footer from "../../Components/Footer.js/Footer";

const IndexUser = () => {
    const dispatch = useDispatch();
    const { theaterList } = useSelector((state) => state.CinemasReducer)

    useEffect(() => {
        dispatch(TheaterListAction());
    }, [dispatch]);

    return (
        <>
            <Header theaterList={theaterList}></Header>
            <div className="main">
                <Outlet />
            </div>
            <Footer></Footer>
        </>
    );
}

export default IndexUser;