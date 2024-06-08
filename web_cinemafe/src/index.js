import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { store } from './Redux/Store';
import { DOMAIN } from './Ustil/Settings/Config';
import { HubConnectionBuilder, LogLevel } from '@microsoft/signalr';
import './index.css'
import 'bootstrap/dist/css/bootstrap.min.css';
import Theater from './Pages/User/Theater/Theater';
import Detail from './Pages/User/Detail/Detail';
import { connection } from './connectionSignalR';
import Routers from './Routers';

    ReactDOM.createRoot(document.getElementById('root')).render(
      <Provider store={store}>
        <Routers />
      </Provider>,
    );
  
