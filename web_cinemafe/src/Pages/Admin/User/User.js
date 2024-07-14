import { Box, Button } from "@mui/material";
import { useEffect, useMemo, useState } from "react";
import { DataGrid, GridToolbar } from '@mui/x-data-grid';
import { useDispatch, useSelector } from "react-redux";
import { GetListUserAction } from "../../../Redux/Actions/UsersAction";
import { format } from 'date-fns';
import UserDialog from "./UserDialog";

const User = () => {
    const dispatch = useDispatch();
    const { listUser } = useSelector((state) => state.UserReducer)

    const [createDialogOpen, setCreateDialogOpen] = useState(false);

    const handleCreateClick = () => {
        setCreateDialogOpen(true);
    };

    const handleCreateDialogClose = () => {
        setCreateDialogOpen(false);
    };

    const columns = useMemo(() => [
        { field: 'fullName', headerName: 'Họ tên', flex: 1 },
        {
            field: 'birthDay',
            headerName: 'Ngày sinh',
            flex: 1,
            renderCell: (params) => `${format(new Date(params.row.birthDay), 'dd/MM/yyyy')}`
        },
        {
            field: 'gender',
            headerName: 'Giới tính',
            flex: 1,
            renderCell: (params) => params.row.gender ? "Nam" : "Nữ"
        },
        { field: 'phone', headerName: 'Số điện thoại', flex: 1 },
        { field: 'email', headerName: 'Email', flex: 1 },
        { field: 'userType', headerName: 'Loại người dùng', flex: 1 },
    ], []);

    useEffect(() => {
        dispatch(GetListUserAction());
    }, [dispatch]);

    return (
        <>
            {listUser ? (
                <>
                    <Box sx={{ width: 1, mb: 2 }}>
                        <Button variant="contained" color="primary" onClick={handleCreateClick}>
                            Thêm người dùng
                        </Button>
                    </Box>
                    <Box sx={{ height: 400, width: 1 }}>
                        <DataGrid
                            rows={listUser}
                            columns={columns}
                            getRowId={(row) => row.phone}
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
                </>
            ) : (
                <p className="text-center">Không có dữ liệu</p>
            )}

            <UserDialog
                open={createDialogOpen}
                onClose={handleCreateDialogClose}
            />
        </>
    );
}

export default User;