import { HubConnectionBuilder, LogLevel } from "@microsoft/signalr";
import { DOMAIN } from "./Ustil/Settings/Config";

export const connection = new HubConnectionBuilder()
    .withUrl(`${DOMAIN}/cinema`, { withCredentials: true })
    .configureLogging(LogLevel.Information)
    .build();
