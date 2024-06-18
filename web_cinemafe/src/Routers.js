import { BrowserRouter as Router , Route, Routes, useLocation } from "react-router-dom";
import Home from "./Pages/User/Home/Home";
import Detail from "./Pages/User/Detail/Detail";
import { createBrowserHistory } from "history";
import BookTickets from "./Pages/User/BookTickets/BookTickets";
import Index from "./Pages/User/Index";
import InfoTicketBooking from "./Pages/User/InfoTicketBooking/InfoTicketBooking";
import Login from "./Pages/User/Login/Login";
import PageViews from "./PageViews";

const Routers = () => {
    return (
        <>
            <Router>
                <PageViews />
                <Routes>
                    <Route path="/" element={<Index />}>
                        <Route index path="" element={<Home />} />
                        <Route path="movie/:id" element={<Detail />} />
                        <Route path="book-tickets/:id" element={<BookTickets />} />
                        <Route path="movie/:movieId" element={<Detail />} />
                        <Route path="infoTicketBooking" element={<InfoTicketBooking />} />
                        <Route path="login" element={<Login />} />
                    </Route>
                </Routes>
            </Router>
        </>
    );
}

export default Routers;