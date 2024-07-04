import { useNavigate, useParams } from "react-router-dom";
import './TheaterDetail.css';
import { useEffect, useState } from "react";
import { GetInfoTheaterByIdAction, UpdateTheaterAction } from "../../../Redux/Actions/CinemasAction";
import { useDispatch, useSelector } from "react-redux";
import { Button, Card, CardActions, CardContent, Collapse, FormControlLabel, Grid, IconButton, Switch, TextField, Typography } from "@mui/material";
import { DOMAIN } from "../../../Ustil/Settings/Config";
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import GenerateSeats from "./GenerateSeat";
import { RoomStatus } from "../../../Enum/RoomStatus";

const TheaterDetail = () => {
    const { id } = useParams();
    const dispatch = useDispatch();
    const { infoTheater } = useSelector((state) => state.CinemasReducer);
    const [formData, setFormData] = useState({
        name: '',
        address: '',
        phone: '',
        image: '',
        status: true,
    });
    const [previewImage, setPreviewImage] = useState('');
    const [expandedCard, setExpandedCard] = useState(null);
    const [seatData, setSeatData] = useState([]); 
    const navigate = useNavigate();
    const [newRoomName, setNewRoomName] = useState('');
    const [newRoomIndex, setNewRoomIndex] = useState(null);

    const handleSwitchChange = (event) => {
        setFormData({ ...formData, [event.target.name]: event.target.checked });
    };

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setFormData({ ...formData, [name]: value });
    };

    const handleImageChange = (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onloadend = () => {
                setPreviewImage(reader.result);
                setFormData({ ...formData, image: file });
            };
            reader.readAsDataURL(file);
        }
    };

    const handleSubmit = (event) => {
        event.preventDefault();

        const formDataToSubmit = {
            id: id,
            name: formData.name,
            address: formData.address,
            phone: formData.phone,
            status: formData.status,
            image: formData.image,
            rooms: seatData,
        };

        console.log(formDataToSubmit);

        dispatch(UpdateTheaterAction(formDataToSubmit, navigate));
    };

    const handleExpandClick = (index) => {
        setExpandedCard(expandedCard === index ? null : index);
    };

    const handleSeatsChange = (updatedSeats) => {
        setSeatData((prevData) => {
            const newData = [...prevData];
            newData[expandedCard] = {
                ...newData[expandedCard],
                rowNameNew: updatedSeats.map(rowSeat => ({ rowSeatsNew: rowSeat }))
            };
            return newData;
        });
    };

    const handleAddRoom = () => {
        const newRoom = {
            name: newRoomName,
            status: false,
            rowNameNew: []
        };
        setSeatData(prevData => [...prevData, newRoom]);
        setNewRoomName('');
        setNewRoomIndex(seatData.length);
        setExpandedCard(null)
    };

    const handleRoomChange = (index, roomName) => {
        setSeatData((prevData) => {
            const newData = [...prevData];
            newData[index] = {
                ...newData[index],
                name: roomName
            };
            return newData;
        });
    };

    const handleRoomStatusChange = (index) => {
        setSeatData((prevData) => {
            const newData = [...prevData];
            newData[index] = {
                ...newData[index],
                status: !newData[index].status === true ? RoomStatus.Active : RoomStatus.WaitForCancellation
            };
            return newData;
        });
    };

    useEffect(() => {
        dispatch(GetInfoTheaterByIdAction(id));
    }, [id, dispatch]);

    useEffect(() => {
        if (infoTheater) {
            setFormData({
                name: infoTheater.name,
                address: infoTheater.address,
                phone: infoTheater.phone,
                status: infoTheater.status,
                image: infoTheater.image
            });
            setPreviewImage(`${DOMAIN}/Images/${infoTheater.image}`);
            setSeatData(infoTheater.rooms || []);
        }
    }, [infoTheater]);

    useEffect(() => {
        console.log(seatData);
        console.log(seatData.rowNameNew);
    }, [formData, seatData]);

    return (
        <>
            <Grid container spacing={2}>
                <Grid item xs={6}>
                    {previewImage && (
                        <>
                            <img
                                src={previewImage}
                                alt={formData.name}
                                style={{ width: '100%', height: 'auto' }}
                            />
                            <input
                                accept="image/*"
                                type="file"
                                onChange={handleImageChange}
                            />
                        </>
                    )}
                </Grid>
                <Grid item xs={6}>
                    <form onSubmit={handleSubmit}>
                        <TextField
                            label="Tên"
                            name="name"
                            value={formData.name}
                            onChange={handleInputChange}
                            fullWidth
                            margin="normal"
                        />
                        <TextField
                            label="Địa chỉ"
                            name="address"
                            value={formData.address}
                            onChange={handleInputChange}
                            fullWidth
                            margin="normal"
                        />
                        <TextField
                            label="Số điện thoại"
                            name="phone"
                            value={formData.phone}
                            onChange={handleInputChange}
                            fullWidth
                            margin="normal"
                        />
                        <FormControlLabel
                            label="Trạng thái"
                            labelPlacement="start"
                            control={
                                <Switch
                                    checked={formData.status}
                                    onChange={handleSwitchChange}
                                    name="status"
                                    color="primary"
                                />
                            }
                        />

                        <Button 
                            type="submit" 
                            variant="contained" 
                            color="primary"
                            style={{ display: 'block', marginTop: '16px' }}
                        >
                            Lưu
                        </Button>
                    </form>
                </Grid>
            </Grid>
            <Grid container spacing={2}>
                <Grid item xs={5} sx={{ display: 'flex', alignItems: 'center' }}>
                    <TextField
                        label="Tạo phòng mới"
                        value={newRoomName}
                        onChange={(e) => setNewRoomName(e.target.value)}
                        fullWidth
                        margin="normal"
                        sx={{ mr: 2 }}
                    />

                    <Button onClick={handleAddRoom} variant="contained" color="primary">
                        Thêm phòng
                    </Button>
                </Grid>
            </Grid>

            {Array.isArray(seatData) && seatData.map((item, index) => (
                <Card key={index}>
                    <CardContent>
                        <Grid container spacing={2} alignItems="center">
                            <Grid item xs={8}>
                                <TextField
                                    label="Room Name"
                                    value={item.name}
                                    onChange={(e) => handleRoomChange(index, e.target.value)}
                                    fullWidth
                                    margin="normal"
                                />
                            </Grid>
                            <Grid item xs={4}>
                                <FormControlLabel
                                    label="Status"
                                    labelPlacement="start"
                                    control={
                                        <Switch
                                            checked={item.status === RoomStatus.Active ? true : false}
                                            onChange={() => handleRoomStatusChange(index)}
                                            name="status"
                                            color="primary"
                                        />
                                    }
                                />
                            </Grid>
                        </Grid>
                    </CardContent>
                    <CardActions disableSpacing>
                        <IconButton
                            onClick={() => handleExpandClick(index)}
                            aria-expanded={expandedCard === index}
                            aria-label="show more"
                            style={{ margin: '0 auto' }}
                        >
                            <ExpandMoreIcon />
                        </IconButton>
                    </CardActions>
                    <Collapse in={expandedCard === index} timeout="auto" unmountOnExit>
                        <CardContent>
                            <GenerateSeats seats={item.rowNameNew.length > 0 ? item.rowNameNew : item.rowName } onSeatsChange={handleSeatsChange} config={false}/>
                        </CardContent>
                    </Collapse>
                </Card>
            ))}
            {newRoomIndex !== null && (
                <Card>
                    <CardContent>
                        <GenerateSeats 
                            seats={[]} 
                            onSeatsChange={(newSeats) => {
                                setSeatData((prevData) => {
                                    const newData = [...prevData];
                                    newData[newRoomIndex].rowNameNew = newSeats;
                                    return newData;
                                });
                            }} 
                            config={true}
                        />
                    </CardContent>
                </Card>
            )}
        </>
    );
};

export default TheaterDetail;
