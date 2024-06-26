import React from 'react';
import { useSelector } from 'react-redux';
import { Navigate } from 'react-router-dom';

export const ProtectedRoute = ({ children }) => {
    const {
        isLoggedIn,
    } = useSelector((state) => state.UserReducer);

    if (!isLoggedIn) {
        return <Navigate to="/login" />;
    }

    return children;
};

export const ProtectedRouteLogin = ({ children }) => {
    const {
        isLoggedIn,
    } = useSelector((state) => state.UserReducer);

    if (isLoggedIn) {
        return <Navigate to="/" />;
    }

    return children;
};