import Axios from "axios";
import { DOMAIN, TOKEN } from "../Ustil/Settings/Config";

export class baseService {
    getToken = () => {
        return sessionStorage.getItem(TOKEN) || localStorage.getItem(TOKEN);
    }

    put = (url, model) => {
        return Axios({
            url: `${DOMAIN}/${url}`,
            method: "PUT",
            data: model,
            headers: { Authorization: `Bearer ${this.getToken()}` }
        });
    };

    post = (url, model) => {
        return Axios({
            url: `${DOMAIN}/${url}`,
            method: "POST",
            data: model,
            headers: { Authorization: `Bearer ${this.getToken()}` }
        });
    };

    postImage = (url, model) => {
        const headers = {
            Authorization: `Bearer ${this.getToken()}`,
            'Content-Type': 'multipart/form-data',
        };

        return Axios({
            url: `${DOMAIN}/${url}`,
            method: "POST",
            data: model,
            headers: headers,
        });
    };

    get = (url) => {
        return Axios({
            url: `${DOMAIN}/${url}`,
            method: "GET",
            headers: { Authorization: `Bearer ${this.getToken()}` }
        });
    };

    delete = (url) => {
        return Axios({
            url: `${DOMAIN}/${url}`,
            method: "DELETE",
            headers: { Authorization: `Bearer ${this.getToken()}` }
        });
    };
}
