import {
    Dialog,
    DialogTitle,
    DialogContent,
    DialogActions,
    Button,
    TextField,
    FormControl,
    InputLabel,
    MenuItem,
    Select,
    Grid,
    Switch,
    FormControlLabel,
    IconButton, FormHelperText,
    Box,
} from '@mui/material';
import PhotoCamera from '@mui/icons-material/PhotoCamera';
import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { GetAgeRestrictionListAction, GetMovieTypeListAction, CreateMovieAction } from "../../../Redux/Actions/CinemasAction";

const MovieFormDialog = ({ open, onClose }) => {
    const [movieData, setMovieData] = useState({
        name: '',
        ageRestrictionId: '',
        image: 'movie.png',
        time2D: -1,
        time3D: -1,
        releaseDate: '',
        actor: '',
        director: '',
        description: '',
        languages: '',
        trailer: '',
        status: false,
        movieTypes: [],
        File: null
    });
    const dispatch = useDispatch();
    const { ageRestrictionList, movieTypeList } = useSelector((state) => state.CinemasReducer);

    const [is2DEnabled, setIs2DEnabled] = useState(true);
    const [is3DEnabled, setIs3DEnabled] = useState(false);
    const [errors, setErrors] = useState({});
    const [trailer, setTrailer] = useState({});
    const [selectedMovieTypes, setSelectedMovieTypes] = useState([]);
    const [trailerDialogOpen, setTrailerDialogOpen] = useState(false);
    // Các hàm xử lý sự kiện
    const handleChange = (e) => {
        const { name, value } = e.target;
        if (name === 'time2D' || name === 'time3D') {
            if (value === "") {
                setErrors({ ...errors, [name]: '' });
                setMovieData({ ...movieData, [name]: '' });
                return
            }
            const numericValue = parseInt(value, 10);
            if (isNaN(numericValue)) {
                return;
            }

            setErrors({ ...errors, [name]: '' });
            setMovieData({ ...movieData, [name]: numericValue });
        } else {
            setErrors({ ...errors, [name]: '' });
            setMovieData({ ...movieData, [name]: value });
        }
    };

    const handleChangeTrailer = (e) => {
        const value = e.target.value;
        setErrors({ ...errors, "trailer": '' });

        if (value.length < 32) {
            setMovieData({ ...movieData, "trailer": "" });
            setTrailer('https://www.youtube.com/watch?v=')
            return
        }
        const res = value.split("v=")[1].split("&")[0];
        setTrailer(res);
        setMovieData({ ...movieData, "trailer": res });
    };

    const handleMovieTypesChange = (event) => {
        const value = event.target.value;
        setSelectedMovieTypes(value);
        setErrors({ ...errors, movieTypes: '' });
        setMovieData({ ...movieData, movieTypes: value });
    };
    const validateInput = () => {
        const errors = {};
        const { name, ageRestrictionId, time2D, time3D, releaseDate, actor, director, description, languages, trailer, image, movieTypes } = movieData;
        if (!name) errors.name = "Tên phim không được để trống";
        if (!ageRestrictionId) errors.ageRestrictionId = "Vui lòng chọn giới hạn độ tuổi";
        if (!is2DEnabled && !is3DEnabled) errors.showtime = "Vui lòng ít nhất 1 định dạng chiếu";
        if (is2DEnabled && (typeof time2D !== 'number' || time2D <= 0)) errors.time2D = "Thời gian 2D phải lớn hơn 0";
        if (is3DEnabled && (typeof time3D !== 'number' || time3D <= 0)) errors.time3D = "Thời gian 3D phải lớn hơn 0";
        if (!releaseDate) errors.releaseDate = "Ngày ra mắt không được để trống";
        if (!actor) errors.actor = "Diễn viên không được để trống";
        if (!director) errors.director = "Đạo diễn không được để trống";
        if (!description) errors.description = "Nội dung không được để trống";
        if (!languages) errors.languages = "Ngôn ngữ không được để trống";
        if (!trailer) errors.trailer = "Mã trailer không được để trống";
        if (image === "movie.png") errors.image = "Chưa chọn ảnh Poster";
        if (movieTypes.length === 0) errors.movieTypes = "Chọn thể loại phim";

        setErrors(errors);
        return Object.keys(errors).length === 0;
    };

    const handleClosing = () => {
        setIs2DEnabled(true);
        setIs3DEnabled(false);
        setErrors({});
        setSelectedMovieTypes([]);

        onClose();
    };

    const handleSwitchChange = (name) => (event) => {
        if (name === 'is2DEnabled') {
            setIs2DEnabled(event.target.checked);
            setMovieData({ ...movieData, "time2D": -1 });
        } else if (name === 'is3DEnabled') {
            setIs3DEnabled(event.target.checked);
            setMovieData({ ...movieData, "time3D": -1 });

        }
    };

    const handlePosterChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setErrors({ ...errors, image: '' });
            setMovieData({ ...movieData, "image": file.name, "File": file });
        }
    };

    const handleSubmit = () => {
        try {

            if (validateInput()) {
                if (!is2DEnabled) {
                    setMovieData({ ...movieData, "time2D": -1 });
                }
                if (!is3DEnabled) {
                    setMovieData({ ...movieData, "time3D": -1 });
                }
                const formDataToSubmit = new FormData();
                for (const key in movieData) {
                    formDataToSubmit.append(key, movieData[key]);
                }
                dispatch(CreateMovieAction(movieData));
                setMovieData({
                    name: "",
                    ageRestrictionId: "",
                    image: "movie.png",
                    time2D: -1,
                    time3D: -1,
                    releaseDate: "",
                    actor: "",
                    director: "",
                    description: "",
                    languages: "",
                    trailer: "",
                    status: false
                })
                setIs2DEnabled(true);
                setIs3DEnabled(false);
                setSelectedMovieTypes([]);
                setErrors({});
                onClose();
            }
        }
        catch (error) {
            console.error('Error:', error.errors);
            error.inner.forEach(err => {
                setErrors(prevErrors => ({
                    ...prevErrors,
                    [err.path]: err.message,
                }));
            });
        }
    };

    useEffect(() => {
        dispatch(GetAgeRestrictionListAction());
        dispatch(GetMovieTypeListAction());
    }, [dispatch]);

    const handleOpenTrailerDialog = () => {
        setTrailerDialogOpen(true);
    };

    const handleCloseTrailerDialog = () => {
        setTrailerDialogOpen(false);
    };

    return (
        <Dialog open={open} onClose={handleClosing} fullWidth maxWidth="md">
            <DialogTitle>Thêm Phim Mới</DialogTitle>
            <DialogContent>
                <Grid container spacing={2}>
                    <Grid item xs={6}>
                        {movieData.File ? (
                            <img
                                src={URL.createObjectURL(movieData.File)} alt='poster'
                                sx={{ width: 100, height: 'auto' }}
                            />
                        ) : (
                            <img src='/Images/movie.png' alt='poster'
                                sx={{ width: 100, height: 'auto' }}

                            />
                        )}
                        <Box mt={2}>
                            <input
                                accept="image/*"
                                id="icon-button-file"
                                type="file"
                                style={{ display: 'none' }}
                                onChange={handlePosterChange}
                            />
                            <label htmlFor="icon-button-file">
                                <IconButton
                                    color="primary"
                                    aria-label="upload picture"
                                    component="span"
                                > Chọn Poster
                                    <PhotoCamera />
                                </IconButton>
                            </label>
                            <FormHelperText>{errors.image}</FormHelperText>
                            {movieData.File && (
                                <Box ml={1}>
                                    {movieData.image}
                                </Box>
                            )}
                        </Box>
                    </Grid>
                    <Grid item xs={6}>
                        <TextField
                            label="Tên phim"
                            name="name"
                            value={movieData.name}
                            onChange={handleChange}
                            fullWidth
                            margin="dense"
                            error={!!errors.name}
                            helperText={errors.name}
                        />
                        <FormControl fullWidth margin="dense" error={!!errors.ageRestrictionId}>
                            <InputLabel id="dropdown-label" sx={{ fontSize: '18px' }}>Giới hạn độ tuổi</InputLabel>
                            <Select
                                name="ageRestrictionId"
                                labelId="dropdown-label"
                                id="dropdown"
                                label="Giới hạn độ tuối"
                                value={movieData.ageRestrictionId}
                                onChange={handleChange}
                                sx={{
                                    color: 'black',
                                    backgroundColor: 'white',
                                }}
                            >
                                {ageRestrictionList.map((ageRestriction) => (
                                    <MenuItem key={ageRestriction.id} value={ageRestriction.id}>{ageRestriction.name} - {ageRestriction.description}  </MenuItem>
                                ))}
                            </Select>
                            <FormHelperText>{errors.ageRestrictionId}</FormHelperText>
                        </FormControl>

                        <Grid container spacing={2} alignItems="center">
                            <Grid item xs={6}>
                                <FormControlLabel
                                    control={
                                        <Switch
                                            checked={is2DEnabled}
                                            onChange={handleSwitchChange('is2DEnabled')}
                                            name="is2DEnabled"
                                        />
                                    }
                                    label="Chiếu 2D"
                                />
                                {is2DEnabled && (
                                    <TextField
                                        label="Thời gian 2D (phút)"
                                        name="time2D"
                                        value={movieData.time2D}
                                        onChange={handleChange}
                                        fullWidth
                                        margin="dense"
                                        error={!!errors.time2D}
                                        helperText={errors.time2D}
                                    />
                                )}
                            </Grid>

                            <Grid item xs={6}>
                                <FormControlLabel
                                    control={
                                        <Switch
                                            checked={is3DEnabled}
                                            onChange={handleSwitchChange('is3DEnabled')}
                                            name="is3DEnabled"
                                        />
                                    }
                                    label="Chiếu 3D"
                                />
                                {is3DEnabled && (
                                    <TextField
                                        label="Thời gian 3D (phút)"
                                        name="time3D"
                                        value={movieData.time3D}
                                        onChange={handleChange}
                                        fullWidth
                                        margin="dense"
                                        error={!!errors.time3D}
                                        helperText={errors.time3D}
                                    />
                                )}
                                <FormHelperText>{errors.showtime}</FormHelperText>
                            </Grid>

                        </Grid>
                        <TextField
                            label="Ngày ra mắt"
                            name="releaseDate"
                            type="date"
                            value={movieData.releaseDate}
                            onChange={handleChange}
                            fullWidth
                            margin="dense"
                            InputLabelProps={{ shrink: true }}
                            error={!!errors.releaseDate}
                            helperText={errors.releaseDate}
                        />
                        <FormControl fullWidth margin="dense" error={!!errors.movieTypes}>
                            <InputLabel id="movie-type-label">Thể loại phim</InputLabel>
                            <Select
                                labelId="movie-type-label"
                                id="movie-type-select"
                                label="Thể loại phim"
                                multiple
                                value={selectedMovieTypes}
                                onChange={handleMovieTypesChange}
                                renderValue={(selected) => selected.map((type) => type.name).join(', ')}
                                sx={{ backgroundColor: 'white' }}
                            >
                                {movieTypeList.map((type) => (
                                    <MenuItem key={type.id} value={type}>
                                        {type.name}
                                    </MenuItem>
                                ))}
                            </Select>
                            <FormHelperText>{errors.movieTypes}</FormHelperText>
                        </FormControl>
                        <TextField
                            label="Diễn viên"
                            name="actor"
                            value={movieData.actor}
                            onChange={handleChange}
                            fullWidth
                            margin="dense"
                            error={!!errors.actor}
                            helperText={errors.actor}
                        />
                        <TextField
                            label="Đạo diễn"
                            name="director"
                            value={movieData.director}
                            onChange={handleChange}
                            fullWidth
                            margin="dense"
                            error={!!errors.director}
                            helperText={errors.director}
                        />
                        <TextField
                            label="Nội dung"
                            name="description"
                            value={movieData.description}
                            onChange={handleChange}
                            fullWidth
                            margin="dense"
                            error={!!errors.description}
                            helperText={errors.description}
                        />
                        <TextField
                            label="Ngôn ngữ"
                            name="languages"
                            value={movieData.languages}
                            onChange={handleChange}
                            fullWidth
                            margin="dense"
                            error={!!errors.languages}
                            helperText={errors.languages}
                        />
                        <TextField
                            label="Mã trailer"
                            name="trailer"
                            value={`https://www.youtube.com/watch?v=${movieData.trailer}`}
                            onChange={handleChangeTrailer}
                            fullWidth
                            margin="dense"
                            error={!!errors.trailer}
                            helperText={errors.trailer}
                        />
                        {movieData.trailer && (
                            <Button onClick={handleOpenTrailerDialog} color="primary" sx={{ mt: 2 }}>
                                Xem trailer
                            </Button>
                        )}
                    </Grid>
                </Grid>
            </DialogContent>
            <DialogActions>
                <Button onClick={handleClosing}>Hủy</Button>
                <Button onClick={handleSubmit} autoFocus color="primary">Thêm</Button>
            </DialogActions>
            <Dialog open={trailerDialogOpen} onClose={handleCloseTrailerDialog} fullWidth maxWidth="md">
                <DialogTitle>Xem Trailer</DialogTitle>
                <DialogContent>
                    <Box sx={{ position: 'relative', paddingTop: '56.25%' }}>
                        <iframe
                            src={`https://www.youtube.com/embed/${trailer}`}
                            frameBorder="0"
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                            allowFullScreen
                            title="Trailer"
                            style={{
                                position: 'absolute',
                                top: 0,
                                left: 0,
                                width: '100%',
                                height: '100%'
                            }}
                        />
                    </Box>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleCloseTrailerDialog}>Đóng</Button>
                </DialogActions>
            </Dialog>
        </Dialog>
    );

};
export default MovieFormDialog;
