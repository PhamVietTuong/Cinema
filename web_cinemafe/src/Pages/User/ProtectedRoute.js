import React from 'react';
import { useSelector } from 'react-redux';
import { Navigate, useLocation} from 'react-router-dom';

export const ProtectedRouteCheckout = ({ children }) => {
    const { isLoggedIn } = useSelector((state) => state.UserReducer);
    const { movieInfoBooking } = useSelector((state) => state.CinemasReducer);
    const location = useLocation();

    if (!isLoggedIn) {
        return <Navigate to="/login" state={{ from: location }} />;
    }

    if (Object.keys(movieInfoBooking).length === 0) {
        return <Navigate to="/"/>;
    }

    return children;
};

export const ProtectedRouteLogin = ({ children }) => {
    const {
        isLoggedIn,
    } = useSelector((state) => state.UserReducer);

    const location = useLocation();
    const from = location.state?.from?.pathname || '/';

    if (isLoggedIn && from === '/') {
        return <Navigate to="/" />;
    }

    return children;
};