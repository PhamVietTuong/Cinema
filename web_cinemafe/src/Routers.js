import { BrowserRouter as Router , Route, Routes } from "react-router-dom";
import Home from "./Pages/User/Home/Home";
import Checkout from "./Pages/User/Checkout/Checkout";
import Detail from "./Pages/User/Detail/Detail";
import { createBrowserHistory } from "history";
import BookTickets from "./Pages/User/BookTickets/BookTickets";
import Index from "./Pages/User/Index";
export const history = createBrowserHistory();

const Routers = () => {
    return (
        <>
            <Router history={history}>
                <Routes>
                    <Route path="/" element={<Index />}>
                        <Route index path="" element={<Home />} />
                        <Route path="movie/:id" element={<Detail />} />
                        <Route path="book-tickets/:id" element={<BookTickets />} />
                        <Route path="movie/:movieId" element={<Detail />} />
                    </Route>
                </Routes>
            </Router>
        </>
    );
}

export default Routers;