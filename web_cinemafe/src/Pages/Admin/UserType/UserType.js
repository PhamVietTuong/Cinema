import { Box, Button, Switch } from "@mui/material";
import { useEffect, useMemo, useState } from "react";
import { DataGrid, GridActionsCellItem, GridToolbar } from '@mui/x-data-grid';
import { useDispatch, useSelector } from "react-redux";
import { GetUserTypeListAction } from "../../../Redux/Actions/CinemasAction";
import { Edit } from "@mui/icons-material";
import UserTypeDialog from "./UserTypeDialog";


const UserType = () => {
    const dispatch = useDispatch();
    const { userTypeList } = useSelector((state) => state.CinemasReducer)

    const [editDialogOpen, setEditDialogOpen] = useState(false);
    const [currentRow, setCurrentRow] = useState(null);
    const [isEditing, setIsEditing] = useState(false);

    const handleEditClick = (row) => {
        setCurrentRow(row);
        setIsEditing(true);
        setEditDialogOpen(true);
    };

    const handleCreateClick = () => {
        setCurrentRow(null);
        setIsEditing(false);
        setEditDialogOpen(true);
    };

    const handleEditDialogClose = () => {
        setEditDialogOpen(false);
        setCurrentRow(null);
    };

    const columns = useMemo(() => [
        { field: 'name', headerName: 'Name', flex: 1 },
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
                // <GridActionsCellItem icon={<Delete />} label="Delete" />,
            ],
        },
    ], []);

    useEffect(() => {
        dispatch(GetUserTypeListAction());
    }, [dispatch]);

    return ( 
        <>
            <Box sx={{ width: 1, mb: 2 }}>
                <Button variant="contained" color="primary" onClick={handleCreateClick}>
                    Add New User Type
                </Button>
            </Box>
            <Box sx={{ height: 400, width: 1 }}>
                <DataGrid
                    rows={userTypeList}
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
                <UserTypeDialog
                    open={editDialogOpen}
                    onClose={handleEditDialogClose}
                    row={currentRow}
                    isEditing={isEditing}
                />
            )}
        </>
     );
}
 
export default UserType;