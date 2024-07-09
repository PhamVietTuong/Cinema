import { Box, Button, IconButton, Typography, Grid } from "@mui/material";
import { DOMAIN } from "../../../Ustil/Settings/Config";
import { format } from 'date-fns';
import { Edit as EditIcon } from "@mui/icons-material";
import HighlightedText from './HighlightedText';
import { useNavigate } from "react-router-dom";

const MovieItem = ({ movie, index }) => {
    const navigate = useNavigate();
    const handleNavigate = () => {
        navigate(`/admin/Movie/${movie.id}`)
    }

    return (
        <Grid item sx={{ display: "flex", mb: 2, position: 'relative' }} xs={12} xl={5.9}>
            <Box sx={{ mr: 1, width: '15px' }}>
                {index}.
            </Box>
            <Box key={movie.id} sx={{ display: "flex", flex: 1, border: "1px solid #000", padding: "10px", borderRadius: '4px' }}>
                <Box sx={{ width: '35%', borderRadius: '4px', marginRight: '10px' }}>
                    <img
                        src={(movie.image === "movie.png") ? `/Images/movie.png` : `${DOMAIN}/Images/${movie.image}`}
                        alt={movie.name}
                        style={{ width: '100%', height: '100%', objectFit: 'cover', borderRadius: '4px', }}
                    />
                </Box>
                <Box sx={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
                    <Box >
                        <Typography variant="h6" sx={{ fontWeight: 'bold' }}>{movie.name}</Typography>
                        <HighlightedText label="Giới hạn độ tuổi" text={movie.ageRestriction.name} />
                        <HighlightedText label="Thời gian 2D" text={`${movie.time2D} phút`} />
                        <HighlightedText label="Thời gian 3D" text={`${movie.time3D} phút`} />
                        <HighlightedText label="Ngày ra mắt" text={format(new Date(movie.releaseDate), 'dd/MM/yyyy')} />
                        <HighlightedText label="Thể loại" text={movie.movieTypes.map(type => type.name).join(', ')} />
                        <HighlightedText label="Diễn viên" text={movie.actor} />
                        <HighlightedText label="Đạo diễn" text={movie.director} />
                        <HighlightedText label="Nội dung" text={movie.description} />
                        <HighlightedText label="Ngôn ngữ" text={movie.languages} />
                        <HighlightedText label="Link youtube trailer" text={movie.trailer} />
                    </Box>
                    <Box>
                        <Button variant="contained" color="primary" sx={{ width: '100%' }} onClick={handleNavigate}>Quản lý suất chiếu</Button>
                    </Box>
                </Box>
                <Box sx={{ position: 'absolute', top: 20, right: 5 }}>
                    <IconButton sx={{ color: 'primary' }} onClick={handleNavigate}>
                        <EditIcon />
                    </IconButton>
                </Box>
            </Box>
        </Grid>
    );
};
export default MovieItem;