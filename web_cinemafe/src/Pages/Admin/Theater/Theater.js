import { Box, Button, Switch } from "@mui/material";
import { useEffect, useMemo, useState } from "react";
import { DataGrid, GridActionsCellItem, GridToolbar } from '@mui/x-data-grid';
import { useDispatch, useSelector } from "react-redux";
import { GetTheaterListAdminAction } from "../../../Redux/Actions/CinemasAction";
import { Edit } from "@mui/icons-material";
import { DOMAIN } from "../../../Ustil/Settings/Config";
import { useNavigate } from "react-router-dom";
import TheaterDialog from "./TheaterDialog";

const Theater = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const { theaterList } = useSelector((state) => state.CinemasReducer)
    
    const [editDialogOpen, setEditDialogOpen] = useState(false);

    const handleEditClick = (row) => {
        navigate(`/admin/theater/${row.id}`);
    };

    const handleCreateClick = () => {
        setEditDialogOpen(true);
    };

    const handleEditDialogClose = () => {
        setEditDialogOpen(false);
    };

    const columns = useMemo(() => [
        { field: 'name', headerName: 'Name', flex: 1 },
        { field: 'address', headerName: 'Address', flex: 1 },
        { 
            field: 'image', 
            headerName: 'Image', 
            flex: 1,
            renderCell: (params) => (
                <img 
                    src={`${DOMAIN}/Images/${params.value}`} 
                    alt={params.row.name} 
                    style={{ width: '100%', height: 'auto' }} 
                />
            )
        },
        { field: 'phone', headerName: 'Phone', flex: 1 },
        {
            field: 'status',
            headerName: 'Status',
            flex: 1,
            renderCell: (params) => (
                <Switch
                    checked={params.value}
                    color="primary"
                />
            )
        },
        {
            field: 'actions',
            type: 'actions',
            width: 100,
            getActions: (params) => [
                <GridActionsCellItem 
                    icon={<Edit />} 
                    label="Edit" 
                    onClick={() => handleEditClick(params.row)} 
                />
            ],
        },
    ], []);

    useEffect(() => {
        dispatch(GetTheaterListAdminAction());
    }, [dispatch]);

    return ( 
        <>
            <Box sx={{ width: 1, mb: 2 }}>
                <Button variant="contained" color="primary" onClick={handleCreateClick}>
                    Add New Theater
                </Button>
            </Box>
            <Box sx={{ height: 400, width: 1 }}>
                <DataGrid
                    rows={theaterList}
                    columns={columns}
                    getRowId={(row) => row.id}
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
            {editDialogOpen && (
                <TheaterDialog
                    open={editDialogOpen}
                    onClose={handleEditDialogClose}
                />
            )}
        </>
     );
}
 
export default Theater;