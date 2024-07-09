import { Box, Button, FormControl, InputLabel, MenuItem, Select, Typography, TextField, Grid } from "@mui/material";
import { format } from 'date-fns';
import { useDispatch, useSelector } from "react-redux";
import { useEffect, useState } from "react";
import MovieItem from "./MovieItem";
import { MovieListAdminAction } from "../../../Redux/Actions/CinemasAction";
import { writeFile, utils } from "xlsx";
import MovieFormDialog from "./MovieDialog";

const MoviePage = () => {
    const dispatch = useDispatch();

    const { movieList } = useSelector((state) => state.CinemasReducer);
    const [selectedStt, setSelectedStt] = useState('true');
    const [selectedRelease, setRelease] = useState('up');
    const [selectedReleased, setSelectedReleased] = useState('all');
    const [filteredMovieList, setFilteredMovieList] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [dialogOpen, setDialogOpen] = useState(false);

    const handleChangeStt = (event) => {
        setSelectedStt(event.target.value);
    };

    const handleChangeRelease = (event) => {
        setRelease(event.target.value);
    };

    const handleChangeReleased = (event) => {
        setSelectedReleased(event.target.value);
    };

    const handleSearchChange = (event) => {
        setSearchTerm(event.target.value);
    };

    useEffect(() => {
        dispatch(MovieListAdminAction());
    }, [dispatch]);

    useEffect(() => {
        const filteredList = movieList.filter((movie) => {
            const matchesStatus = (selectedStt === 'true' && movie.status === true) ||
                (selectedStt === 'false' && movie.status === false) ||
                selectedStt === 'none';

            const matchesSearch = movie.name.toLowerCase().includes(searchTerm.toLowerCase());

            const matchesReleased = (selectedReleased === 'released' && new Date(movie.releaseDate) <= new Date()) ||
                (selectedReleased === 'unreleased' && new Date(movie.releaseDate) > new Date()) ||
                selectedReleased === 'all';

            return matchesStatus && matchesSearch && matchesReleased;
        });

        const sortedList = filteredList.sort((a, b) => {
            const dateA = new Date(a.releaseDate);
            const dateB = new Date(b.releaseDate);
            return selectedRelease === 'up' ? dateA - dateB : dateB - dateA;
        });

        setFilteredMovieList(sortedList);
    }, [movieList, selectedStt, selectedRelease, selectedReleased, searchTerm]);

    const handleExport = () => {
        const data = filteredMovieList.map((movie, index) => ({
            "STT": index + 1,
            "Tên phim": movie.name,
            "Giới hạn độ tuổi": movie.ageRestriction.name,
            "Thời gian 2D": `${movie.time2D} phút`,
            "Thời gian 3D": `${movie.time3D} phút`,
            "Ngày ra mắt": format(new Date(movie.releaseDate), 'dd/MM/yyyy'),
            "Thể loại": movie.movieTypes.map((movieType) => movieType.name).join(', '),
            "Diễn viên": movie.actor,
            "Đạo diễn": movie.director,
            "Nội dung": movie.description,
            "Ngôn ngữ": movie.languages,
            "Mã trailer": movie.trailer,
            "Đã ra mắt": new Date(movie.releaseDate) <= new Date() ? 'Đã ra mắt' : 'Chưa ra mắt',
        }));
        const worksheet = utils.json_to_sheet(data);
        const workbook = utils.book_new();
        utils.book_append_sheet(workbook, worksheet, "Movies");
        writeFile(workbook, "Movies.xlsx");
    };

    return (
        <>
            <Box sx={{ mb: 2, display: "flex", alignItems: "center" }}>
                <Box sx={{ width: '17ch', mr: 2 }}>
                    <FormControl fullWidth>
                        <InputLabel id="status-dropdown-label" sx={{ fontSize: '18px' }}>Trạng thái</InputLabel>
                        <Select
                            labelId="status-dropdown-label"
                            id="dropdown"
                            value={selectedStt}
                            onChange={handleChangeStt}
                            label="Trạng thái"
                            sx={{
                                color: 'black',
                                backgroundColor: 'white',
                            }}
                        >
                            <MenuItem value="none">Tất cả</MenuItem>
                            <MenuItem value="true">Hoạt động</MenuItem>
                            <MenuItem value="false">Tạm ẩn</MenuItem>
                        </Select>
                    </FormControl>
                </Box>
                <Box sx={{ width: '17ch', mr: 2 }}>
                    <FormControl fullWidth>
                        <InputLabel id="release-dropdown-label" sx={{ fontSize: '18px' }}>Ngày ra mắt</InputLabel>
                        <Select
                            labelId="release-dropdown-label"
                            id="dropdown"
                            value={selectedRelease}
                            onChange={handleChangeRelease}
                            label="Ngày ra mắt"
                            sx={{
                                color: 'black',
                                backgroundColor: 'white',
                            }}
                        >
                            <MenuItem value="up">Gần nhất</MenuItem>
                            <MenuItem value="dow">Xa nhất</MenuItem>
                        </Select>
                    </FormControl>
                </Box>
                <Box sx={{ width: '17ch', mr: 2 }}>
                    <FormControl fullWidth>
                        <InputLabel id="released-dropdown-label" sx={{ fontSize: '18px' }}>Đã ra mắt</InputLabel>
                        <Select
                            labelId="released-dropdown-label"
                            id="dropdown"
                            value={selectedReleased}
                            onChange={handleChangeReleased}
                            label="Đã ra mắt"
                            sx={{
                                color: 'black',
                                backgroundColor: 'white',
                            }}
                        >
                            <MenuItem value="all">Tất cả</MenuItem>
                            <MenuItem value="released">Đã ra mắt</MenuItem>
                            <MenuItem value="unreleased">Chưa ra mắt</MenuItem>
                        </Select>
                    </FormControl>
                </Box>
                <TextField
                    label="Tìm kiếm"
                    variant="outlined"
                    value={searchTerm}
                    onChange={handleSearchChange}
                    sx={{ mr: 2 }}
                />
                <Button variant="contained" color="primary" onClick={() => setDialogOpen(true)}>
                    Thêm phim
                </Button>
                <Button variant="contained" color="secondary" onClick={handleExport} sx={{ ml: 2 }}>
                    Export
                </Button>
            </Box>
            <Grid container spacing={2} sx={{ justifyContent: 'space-between', padding: 2 }}>
                {filteredMovieList.length === 0 ? <Typography>Không tìm được phim.</Typography> : filteredMovieList.map((movie, idx) => (
                    <MovieItem key={movie.id} movie={movie} index={idx + 1} />
                ))}
            </Grid>
            <MovieFormDialog
                open={dialogOpen}
                onClose={() => setDialogOpen(false)}
                onSubmit={(movie) => {
                    console.log(movie);
                }}
            />
        </>
    );
};

export default MoviePage;
