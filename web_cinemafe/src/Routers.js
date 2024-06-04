import { BrowserRouter as Router , Route, Routes } from "react-router-dom";
import Home from "./Pages/User/Home/Home";
import Checkout from "./Pages/User/Checkout/Checkout";
import Detail from "./Pages/User/Detail/Detail";
import { createBrowserHistory } from "history";
export const history = createBrowserHistory();

const Routers = () => {
    return (
        <>
            <Router history={history}>
                <Routes>
                    <Route path="/" element={<Home />} />
                    <Route path="checkout" element={<Checkout />} />
                    <Route path="detail/:id" element={<Detail />} />
                </Routes>

            </Router  >
        </>
    );
}

export default Routers;