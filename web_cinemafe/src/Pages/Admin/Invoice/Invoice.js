import { Box, Switch } from "@mui/material";
import { useEffect, useMemo } from "react";
import { DataGrid, GridToolbar } from '@mui/x-data-grid';
import { useDispatch, useSelector } from "react-redux";
import { GetListInvoiceAction } from "../../../Redux/Actions/CinemasAction";
import moment from "moment";
import { format } from 'date-fns';

const formatCurrency = (value) => {
    return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
};

const Invoice = () => {
    const dispatch = useDispatch();
    const { listInvoice } = useSelector((state) => state.CinemasReducer)

    const columns = useMemo(() => [
        { field: 'code', headerName: 'Mã đơn', flex: 1 },
        { field: 'movieName', headerName: 'Tên phim', flex: 1 },
        {
            field: 'showTime',
            headerName: 'Suất chiếu',
            flex: 1,
            renderCell: (params) => `${moment(params.row.showTimeStartTime).format("HH:mm")} - ${moment(params.row.showTimeEndTime).format("HH:mm")} (${format(new Date(params.row.showTimeStartTime), 'dd/MM/yyyy')})`
        },
        {
            field: 'showRoom',
            headerName: 'Phòng chiếu',
            flex: 1,
            renderCell: (params) => `${params.row.roomName} - ${params.row.theaterName}`
        },
        {
            field: 'status',
            headerName: 'Trạng thái',
            flex: 1,
            renderCell: (params) => {
                switch (params.value) {
                    case 0:
                        return 'Chưa thanh toán';
                    case 1:
                        return 'Đã thanh toán';
                    case 2:
                        return 'Đã hủy';
                    default:
                        return 'Không xác định';
                }
            }
        },
        {
            field: 'totalPrice',
            headerName: 'Tổng tiền',
            flex: 1,
            renderCell: (params) => `${formatCurrency(params.row.totalPrice)}`
        },
        {
            field: 'creationTime',
            headerName: 'Ngày đặt',
            flex: 1,
            renderCell: (params) => `${format(new Date(params.row.creationTime), 'dd/MM/yyyy')}`
        },
    ], []);

    useEffect(() => {
        dispatch(GetListInvoiceAction());
    }, [dispatch]);

    return (
        <>
            {listInvoice ? (              
                    <Box sx={{ height: 400, width: 1 }}>
                        <DataGrid
                            rows={listInvoice}
                            columns={columns}
                            getRowId={(row) => row.code}
                            disableColumnFilter
                            disableColumnSelector
                            disableDensitySelector
                            slots={{ toolbar: GridToolbar }}
                            slotProps={{
                                toolbar: {
                                    showQuickFilter: true,
                                },
                            }}
                        />
                    </Box>
            ) : (
                <p className="text-center">Không có dữ liệu</p>
            )}

        </>
    );
}

export default Invoice;