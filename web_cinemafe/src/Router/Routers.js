import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "../Pages/User/Home/Home";
import Detail from "../Pages/User/Detail/Detail";
import BookTickets from "../Pages/User/BookTickets/BookTickets";
import InfoTicketBooking from "../Pages/User/InfoTicketBooking/InfoTicketBooking";
import Login from "../Pages/User/Login/Login";
import PageViews from "./PageViews";
import IndexUser from "../Pages/User/IndexUser";
import IndexAdmin from "../Pages/Admin/IndexAdmin";
import AgeRestriction from "../Pages/Admin/AgeRestriction/AgeRestriction";
import Checkout from "../Pages/User/Checkout/Checkout";
import { ProtectedRouteAdmin, ProtectedRouteCheckout, ProtectedRouteInfo, ProtectedRouteLogin } from "./ProtectedRoute";
import ForgetPassword from "../Pages/User/ForgetPassword/ForgetPassword";
import TicketType from "../Pages/Admin/TicketType/TicketType";
import MovieType from "../Pages/Admin/MovieType/MovieType";
import SeatType from "../Pages/Admin/SeatType/SeatType";
import UserType from "../Pages/Admin/UserType/UserType";
import Theater from "../Pages/Admin/Theater/Theater";
import ScrollToTop from "./ScrollToTop";
import TheaterDetail from "../Pages/Admin/Theater/TheaterDetail";
import Profile from "../Pages/User/Account/Profile";
import Showing from "../Pages/User/Showing/Showing";
import Cooming from "../Pages/User/Cooming/Cooming";
import MoviePage from "../Pages/Admin/Movie/MoviePage";
import EditMoviePage from "../Pages/Admin/Movie/EditMoviePage";
import Revenue from "../Pages/Admin/Revenue/Revenue";
import Invoice from "../Pages/Admin/Invoice/Invoice";
import User from "../Pages/Admin/User/User";
import ShowTime from "../Pages/Admin/ShowTime/ShowTime";
import News from "../Pages/User/News/News";
import Special from "../Pages/User/Special/Special";

const Routers = () => {
    return (
        <>
            <Router>
                <PageViews />
                <ScrollToTop />
                <Routes>
                    <Route path="/" element={<IndexUser />}>
                        <Route index path="" element={<Home />} />
                        <Route path="movie/:id" element={<Detail />} />
                        <Route path="book-tickets/:id" element={<BookTickets />} />
                        <Route path="movie/:movieId" element={<Detail />} />
                        <Route path="showing" element={<Showing />} />
                        <Route path="cooming" element={<Cooming />} />
                        <Route path="special" element={<Special/>} />
                        <Route
                            path="login"
                            element={
                                <ProtectedRouteLogin>
                                    <Login />
                                </ProtectedRouteLogin>
                            }
                        />
                        <Route
                            path="change-pass"
                            element={
                                <ProtectedRouteLogin>
                                    <ForgetPassword />
                                </ProtectedRouteLogin>
                            }
                        />
                        <Route
                            path="checkout"
                            element={
                                <ProtectedRouteCheckout>
                                    <Checkout />
                                </ProtectedRouteCheckout>
                            }
                        />
                        <Route path="checkout/info" element={<InfoTicketBooking />} />
                        <Route path="account/account-profile" element={
                            <ProtectedRouteInfo>
                                <Profile />
                            </ProtectedRouteInfo>} 
                        />
                        <Route path="news" element={<News/>}
                        />
                    </Route>
                    <Route path="/admin" element={
                        <ProtectedRouteAdmin>
                            <IndexAdmin />
                        </ProtectedRouteAdmin>
                    }>
                        <Route index path="admin" element={<AgeRestriction />} />
                        <Route path="Movie" element={<MoviePage />} />
                        <Route path="Movie/:id" element={<EditMoviePage />} />
                        <Route path="AgeRestriction" element={<AgeRestriction />} />
                        <Route path="TicketType" element={<TicketType />} />
                        <Route path="MovieType" element={<MovieType />} />
                        <Route path="SeatType" element={<SeatType />} />
                        <Route path="UserType" element={<UserType />} />
                        <Route path="theater" element={<Theater />} />
                        <Route path="theater/:id" element={<TheaterDetail />} />
                        <Route path="revenue" element={<Revenue />} />
                        <Route path="invoice" element={<Invoice />} />
                        <Route path="user" element={<User />} />
                        <Route path="showTime" element={<ShowTime />} />
                    </Route>
                </Routes>
            </Router>
        </>
    );
}

export default Routers;