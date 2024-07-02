import Axios from "axios";
import { DOMAIN, TOKEN } from "../Ustil/Settings/Config";

export class baseService {
    put = (url, model) => {
        return Axios({
            url: `${DOMAIN}/${url}`,
            method: "PUT",
            data: model,
            headers: { Authorization: "Bearer " + sessionStorage.getItem(TOKEN) }, 
        });
    };

    post = (url, model) => {
        return Axios({
            url: `${DOMAIN}/${url}`,
            method: "POST",
            data: model,
            headers: { Authorization: "Bearer " + sessionStorage.getItem(TOKEN) }, 
        });
    };

    postImage = (url, model) => {
        const headers = {
            Authorization: "Bearer " + sessionStorage.getItem(TOKEN),
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
            headers: { Authorization: "Bearer " + sessionStorage.getItem(TOKEN) },
        });
    };

    delete = (url) => {
        return Axios({
            url: `${DOMAIN}/${url}`,
            method: "DELETE",
            headers: { Authorization: "Bearer " + sessionStorage.getItem(TOKEN) },
        });
    };
}
