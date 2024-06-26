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
import Test from "./Pages/Admin/Test";
import Checkout from "./Pages/User/Checkout/Checkout";
import { ProtectedRoute, ProtectedRouteLogin } from "./Pages/User/ProtectedRoute";
import ForgetPassword from "./Pages/User/ForgetPassword/ForgetPassword";

const Routers = () => {
    return (
        <>
            <Router>
                <PageViews />
                <Routes>
                    <Route path="/" element={<IndexUser />}>
                        <Route index path="" element={<Home />} />
                        <Route path="movie/:id" element={<Detail />} />
                        <Route path="book-tickets/:id" element={<BookTickets />} />
                        <Route path="movie/:movieId" element={<Detail />} />
                        <Route path="infoTicketBooking" element={<InfoTicketBooking />} />
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
                                <ProtectedRoute>
                                    <Checkout />
                                </ProtectedRoute>
                            }
                        />
                    </Route>
                    <Route path="/admin" element={<IndexAdmin />}>
                        <Route index path="admin" element={<AgeRestriction />} />
                        <Route path="AgeRestriction" element={<AgeRestriction />} />
                        <Route path="Drafts" element={<Test />} />
                    </Route>
                </Routes>
            </Router>
        </>
    );
}

export default Routers;