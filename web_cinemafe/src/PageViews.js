import { useEffect } from 'react';
import { useLocation, Navigate } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { connection } from './connectionSignalR';
import { CLEAN } from './Redux/Actions/Type/CinemasType';

const PageViews = () => {
    const location = useLocation();
    const dispatch = useDispatch();

    useEffect(() => {
        const disconnectAction = async () => {
            if (connection) {
                await connection.stop();

                await dispatch({
                    type: CLEAN,
                });
            }
        };

        if (location.pathname === '/' || location.pathname.startsWith('/book-tickets/')) {
            disconnectAction();
        }
    }, [location, dispatch]);

    return null;
}

export default PageViews;
