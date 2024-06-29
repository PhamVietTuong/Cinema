import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "./Pages/User/Home/Home";
import Detail from "./Pages/User/Detail/Detail";
import BookTickets from "./Pages/User/BookTickets/BookTickets";
import InfoTicketBooking from "./Pages/User/InfoTicketBooking/InfoTicketBooking";
import Login from "./Pages/User/Login/Login";
import PageViews from "./PageViews";
import IndexUser from "./Pages/User/IndexUser";
import IndexAdmin from "./Pages/Admin/IndexAdmin";
import AgeRestriction from "./Pages/Admin/AgeRestriction/AgeRestriction";
import Checkout from "./Pages/User/Checkout/Checkout";
import { ProtectedRoute, ProtectedRouteCheckout, ProtectedRouteLogin } from "./Pages/User/ProtectedRoute";
import ForgetPassword from "./Pages/User/ForgetPassword/ForgetPassword";
import TicketType from "./Pages/Admin/TicketType/TicketType";
import MovieType from "./Pages/Admin/MovieType/MovieType";
import SeatType from "./Pages/Admin/SeatType/SeatType";
import UserType from "./Pages/Admin/UserType/UserType";
import Theater from "./Pages/Admin/Theater/Theater";
import ScrollToTop from "./ScrollToTop";
import UserType from "./Pages/Admin/UserType/UserType";
import Theater from "./Pages/Admin/Theater/Theater";

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
                    </Route>
                    <Route path="/admin" element={<IndexAdmin />}>
                        <Route index path="admin" element={<AgeRestriction />} />
                        <Route path="AgeRestriction" element={<AgeRestriction />} />
                        <Route path="TicketType" element={<TicketType />} />
                        <Route path="MovieType" element={<MovieType />} />
                        <Route path="SeatType" element={<SeatType />} />
                        <Route path="UserType" element={<UserType />} />
                        <Route path="Theater" element={<Theater />} />
                    </Route>
                </Routes>
            </Router>
        </>
    );
}

export default Routers;