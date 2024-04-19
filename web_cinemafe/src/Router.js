import { BrowserRouter, Route, Routes } from "react-router-dom";
import Home from "./Pages/User/Home/Home";
import Checkout from "./Pages/User/Checkout/Checkout";
import Detail from "./Pages/User/Detail/Detail";

const Router = () => {
    return (
        <>
            <BrowserRouter>
                <Routes>
                    {/* <Route path="/" element={<Home />}/>
                    <Route path="home" element={<Home />} />
                    <Route path="checkout" element={<Checkout />} /> */}
                    {/* <Route path="detail/:id" element={<Detail />} /> */}
                    <Route path="detail/:id" element={<Detail />} />
                </Routes>

            </BrowserRouter >
        </>
    );
}

export default Router;