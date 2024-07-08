import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { GetRevenueAction } from "../../../Redux/Actions/CinemasAction";
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend } from 'chart.js';
import { Bar } from 'react-chartjs-2';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';
import { TextField, Box } from '@mui/material';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import dayjs from "dayjs";
import { LocalizationProvider } from "@mui/x-date-pickers";

ChartJS.register(
    CategoryScale,
    LinearScale,
    BarElement,
    Title,
    Tooltip,
    Legend
);

const Revenue = () => {
    const dispatch = useDispatch();
    const { dataRevenue } = useSelector((state) => state.CinemasReducer);
    const [startDate, setStartDate] = useState(null);
    const [endDate, setEndDate] = useState(null);

    useEffect(() => {
        dispatch(GetRevenueAction({ startDate: null, endDate: null }));
    }, [dispatch]);
     
    const fetchData = () => {
        const formattedStartDate = startDate ? dayjs(startDate).format('YYYY-MM-DDTHH:mm:ss') : null;
        const formattedEndDate = endDate ? dayjs(endDate).format('YYYY-MM-DDTHH:mm:ss') : null;

        dispatch(GetRevenueAction({ startDate: formattedStartDate, endDate: formattedEndDate }));
    };

    useEffect(() => {
        if (startDate || endDate) {
            fetchData();
        }
    }, [startDate, endDate]);

    const data = {
        labels: dataRevenue.map(item => item.theaterName),
        datasets: [
            {
                label: 'Tổng tiền vé',
                data: dataRevenue.map(item => item.totalSeat), 
                backgroundColor: 'rgba(75, 192, 192, 0.6)',
            },
            {
                label: 'Tổng tiền đồ ăn và thức uống',
                data: dataRevenue.map(item => item.totalFoodAndDrink), 
                backgroundColor: 'rgba(153, 102, 255, 0.6)',
            },
            {
                label: 'Tổng tiền',
                data: dataRevenue.map(item => item.totalPrice), 
                backgroundColor: 'rgba(255, 159, 64, 0.6)',
            },
        ],
    };

    const options = {
        responsive: true,
        plugins: {
            legend: {
                position: 'top',
            },
            title: {
                display: true,
                text: 'Thông kế doanh thu',
            },
        },
    };

    return (
        <LocalizationProvider dateAdapter={AdapterDayjs}>
            <Box display="flex" justifyContent="center" alignItems="center" flexDirection="column">
                <DatePicker
                    label="Start Date"
                    value={startDate}
                    onChange={(newValue) => setStartDate(newValue)}
                    renderInput={(params) => <TextField {...params} />}
                />
                <DatePicker
                    label="End Date"
                    value={endDate}
                    onChange={(newValue) => setEndDate(newValue)}
                    renderInput={(params) => <TextField {...params} />}
                />
                <Box width="80%" marginTop="20px">
                    <Bar data={data} options={options} />
                </Box>
            </Box>
        </LocalizationProvider>
    );
}

export default Revenue;
