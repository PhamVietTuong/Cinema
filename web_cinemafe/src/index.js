import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { store } from './Redux/Store';
import './index.css'
import 'bootstrap/dist/css/bootstrap.min.css';
import Routers from './Router/Routers';

    ReactDOM.createRoot(document.getElementById('root')).render(
      <Provider store={store}>
        <Routers />
      </Provider>,
    );
  
