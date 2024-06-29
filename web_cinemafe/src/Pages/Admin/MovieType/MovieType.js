import { Box, Button, Switch } from "@mui/material";
import { useEffect, useMemo, useState } from "react";
import { DataGrid, GridActionsCellItem, GridToolbar } from '@mui/x-data-grid';
import { useDispatch, useSelector } from "react-redux";
import { GetMovieTypeListAction } from "../../../Redux/Actions/CinemasAction";
import { Edit } from "@mui/icons-material";
import MovieTypeDialog from "./MovieTypeDialog";


const MovieType = () => {
    const dispatch = useDispatch();
    const { movieTypeList } = useSelector((state) => state.CinemasReducer)

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
                // <GridActionsCellItem icon={<Delete />} label="Delete" />,
            ],
        },
    ], []);

    useEffect(() => {
        dispatch(GetMovieTypeListAction());
    }, [dispatch]);

    return ( 
        <>
            <Box sx={{ width: 1, mb: 2 }}>
                <Button variant="contained" color="primary" onClick={handleCreateClick}>
                    Add New Movie Type
                </Button>
            </Box>
            <Box sx={{ height: 400, width: 1 }}>
                <DataGrid
                    rows={movieTypeList}
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
                <MovieTypeDialog
                    open={editDialogOpen}
                    onClose={handleEditDialogClose}
                    row={currentRow}
                    isEditing={isEditing}
                />
            )}
        </>
     );
}
 
export default MovieType;