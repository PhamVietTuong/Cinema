import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from "react-redux";
import { DOMAIN } from "../../../Ustil/Settings/Config";
import { useNavigate, useParams } from "react-router-dom";
import { MovieByIdActionAdmin, GetAgeRestrictionListAction, GetMovieTypeListAction } from "../../../Redux/Actions/CinemasAction"
import { TextField, Grid, Button, Box, FormControl, InputLabel, Select, MenuItem, FormHelperText, } from "@mui/material";

const EditMoviePage = () => {
    const { id } = useParams();
    const dispatch = useDispatch();
    const { movie, ageRestrictionList, movieTypeList } = useSelector((state) => state.CinemasReducer);
    const [errors, setErrors] = useState({});
    const [selectedMovieTypes, setSelectedMovieTypes] = useState([]);

    const [movieData, setMovieData] = useState({
        name: '',
        ageRestrictionId: "",
        ageRestriction: {
            id: '',
            name: '',
            status: '',
        },
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

    const handleMovieTypesChange = (event) => {
        const value = event.target.value;
        setErrors({ ...errors, movieTypes: '' });
        setSelectedMovieTypes(value);
        var res = []
        movieTypeList.forEach(element => {
            if (value.includes(element.id)) {
                res.push(element)
            }
        });
        setMovieData({ ...movieData, movieTypes: res });
        console.log(movieData)
    };
    useEffect(() => {
        if (movie) {
            setMovieData({
                ...movie,
            });
            setSelectedMovieTypes(movie.movieTypes?.map((movieType) => movieType.id));
        }
        console.log(movie);
    }, [movie]);

    const handleChange = (event) => {
        const { name, value } = event.target;
        setMovieData((prevData) => ({
            ...prevData,
            [name]: value,
        }));
    };



    const handleSubmit = (event) => {
        event.preventDefault();
    };
    useEffect(() => {
        dispatch(MovieByIdActionAdmin(id));
        dispatch(GetAgeRestrictionListAction());
        dispatch(GetMovieTypeListAction());
    }, [dispatch, id]);

    return (
        <Box component="form" onSubmit={handleSubmit} sx={{ margin: 'auto', mt: 5 }}>
            <Grid container spacing={2} display={"flex"}>
                <Grid item sm={3} xs={12} sx={{ borderRadius: '4px', }}>
                    <img
                        src={(movie.image === "movie.png") ? `/Images/movie.png` : `${DOMAIN}/Images/${movie.image}`}
                        alt={movie.name}
                        style={{ width: '100%', height: '100%', objectFit: 'cover', borderRadius: '4px', }}
                    />
                </Grid>
                <Grid item sm={9} xs={12} sx={{}}>
                    <TextField
                        margin="dense"
                        name="name"
                        label="Tên phim"
                        type="text"
                        fullWidth
                        variant="outlined"
                        value={movieData.name}
                        onChange={handleChange}
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
                    <TextField
                        margin="dense"
                        name="time2D"
                        label="Thời gian 2D"
                        type="number"
                        fullWidth
                        variant="outlined"
                        value={movieData.time2D}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="time3D"
                        label="Thời gian 3D"
                        type="number"
                        fullWidth
                        variant="outlined"
                        value={movieData.time3D}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="actor"
                        label="Diễn viên"
                        type="text"
                        multiline
                        fullWidth
                        variant="outlined"
                        value={movieData.actor}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="description"
                        label="Nội dung"
                        type="text"
                        fullWidth
                        multiline
                        variant="outlined"
                        value={movieData.description}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="languages"
                        label="Ngôn ngữ"
                        type="text"
                        fullWidth
                        variant="outlined"
                        value={movieData.languages}
                        onChange={handleChange}
                    />

                    <TextField
                        label="Ngày ra mắt"
                        name="releaseDate"
                        type="date"
                        value={movieData.releaseDate?.split("T")[0]}
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
                            renderValue={(selected) => {
                                var values = []
                                movieTypeList.map((movieType) => {
                                    if (selected.includes(movieType.id)) {
                                        values.push(movieType)
                                    }
                                    return true;
                                })
                                const res = values.sort((a, b) => selected.indexOf(a.id) - selected.indexOf(b.id))
                                return res.map((movieType) => movieType.name).join(', ');
                            }}
                            sx={{ backgroundColor: 'white' }}
                        >
                            {movieTypeList.map((type) => (
                                <MenuItem key={type.id} value={type.id}>
                                    {type.name}
                                </MenuItem>
                            ))}
                        </Select>
                        <FormHelperText>{errors.movieTypes}</FormHelperText>
                    </FormControl>

                    <TextField
                        margin="dense"
                        name="director"
                        label="Đạo diễn"
                        type="text"
                        fullWidth
                        variant="outlined"
                        value={movieData.director}
                        onChange={handleChange}
                    />
                    <TextField
                        margin="dense"
                        name="trailer"
                        label="Mã trailer"
                        type="text"
                        fullWidth
                        variant="outlined"
                        value={movieData.trailer}
                        onChange={handleChange}
                    />
                </Grid>
            </Grid>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 2 }}>
                <Button onClick={() => { }} color="secondary">Hủy</Button>
                <Button type="submit" color="primary">Lưu</Button>
            </Box>
        </Box>
    );
};

export default EditMoviePage;
