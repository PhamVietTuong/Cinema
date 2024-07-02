import { Button, MenuItem, Select, TextField } from "@mui/material";
import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { GetSeatTypeListAction } from "../Redux/Actions/CinemasAction";

const getSeatTypeId = (data, name) => {
    const seatType = data.find(x => x.name === name);
    return seatType ? seatType.id : null;
}

const getSeatTypeName = (data, id) => {
    const seatType = data.find(x => x.id === id);
    return seatType ? seatType.name : '';
}

const GenerateSeats = (props) => {
    const { onSeatsChange } = props;
    const dispatch = useDispatch();
    const { seatTypeList } = useSelector((state) => state.CinemasReducer);

    const [seatMatrix, setSeatMatrix] = useState([]);
    const [rows, setRows] = useState(3);
    const [cols, setCols] = useState(3);
    const [seatType, setSeatType] = useState('');
    const [hoveredSeat, setHoveredSeat] = useState(null);

    const handleSeatClick = (rowIndex, colIndex) => {
        const updatedMatrix = seatMatrix.map((row, rIdx) =>
            row.map((seat, cIdx) => {
                if (rIdx === rowIndex && cIdx === colIndex) {
                    return {
                        ...seat,
                        isSeat: !seat.isSeat
                    };
                }
                return seat;
            })
        );
        setSeatMatrix(updatedMatrix);
        onSeatsChange(updatedMatrix);
    };

    const handleSeatTypeChange = (rowIndex, colIndex, seatTypeId) => {
        const updatedMatrix = seatMatrix.map((row, rIdx) => {
            if (rIdx === rowIndex) {
                let newRow = row.reduce((acc, seat, cIdx) => {
                    if (cIdx === colIndex) {
                        if (getSeatTypeName(seatTypeList, seat.seatTypeId) === "Ðôi" &&
                            (getSeatTypeName(seatTypeList, seatTypeId) === "Đơn" || getSeatTypeName(seatTypeList, seatTypeId) === "Nằm")) {
                            acc.push({
                                ...seat,
                                seatTypeId: seatTypeId,
                                isSeat: false
                            });
                            acc.push({
                                ...seat,
                                seatTypeId: seatTypeId,
                                colIndex: colIndex + 1,
                                isSeat: false
                            });
                        } else if ((getSeatTypeName(seatTypeList, seat.seatTypeId) === "Đơn" || getSeatTypeName(seatTypeList, seat.seatTypeId) === "Nằm") &&
                            getSeatTypeName(seatTypeList, seatTypeId) === "Ðôi") {
                            const nextSeat = row[colIndex + 1];
                            if (nextSeat && (getSeatTypeName(seatTypeList, nextSeat.seatTypeId) === "Đơn" || getSeatTypeName(seatTypeList, nextSeat.seatTypeId) === "Nằm")) {
                                acc.push({
                                    ...seat,
                                    seatTypeId: seatTypeId,
                                    isSeat: false
                                });
                                row.splice(colIndex + 1, 1);
                            } else {
                                acc.push(seat);
                            }
                        } else {
                            acc.push({
                                ...seat,
                                seatTypeId: seatTypeId
                            });
                        }
                    } else if (cIdx !== colIndex) {
                        acc.push(seat);
                    }
                    return acc;
                }, []);

                newRow = newRow.map((seat, newIdx) => ({
                    ...seat,
                    colIndex: newIdx + 1
                }));

                return newRow;
            }
            return row;
        });
        setSeatMatrix(updatedMatrix);
        onSeatsChange(updatedMatrix);
    };

    const generateSeats = () => {
        if (seatTypeList.length > 0) {
            const initialMatrix = Array.from({ length: rows }, (_, rowIndex) =>
                Array.from({ length: cols }, (_, colIndex) => ({
                    colIndex: colIndex + 1,
                    rowName: String.fromCharCode(65 + rowIndex),
                    seatTypeId: seatType,
                    isSeat: false
                }))
            );
            setSeatMatrix(initialMatrix);
            onSeatsChange(initialMatrix);
        }
    };

    useEffect(() => {
        dispatch(GetSeatTypeListAction());
    }, [dispatch]);

    useEffect(() => {
        if (seatTypeList.length > 0) {
            setSeatType(seatTypeList[0].id);
        }
    }, [seatTypeList]);

    useEffect(() => {
        if (props.seats && props.seats.length > 0) {
            setSeatMatrix(props.seats.map(row => row.rowSeats));
        }
    }, [props.seats]);

    const seatWidth = 50;
    const doubleSeatWidth = 110;
    const seatHeight = 100;
    const gap = 10;

    const calculateTotalWidth = () => {
        if (seatMatrix.length === 0) return 0;
        return seatMatrix[0].reduce((totalWidth, seat) => {
            const width = seat.seatTypeId === getSeatTypeId(seatTypeList, "Ðôi") ? doubleSeatWidth : seatWidth;
            return totalWidth + width + gap;
        }, -gap);
    };

    return (
        <>
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh', flexDirection: 'column' }}>
                            <h3>Generate Seats</h3>
                            <form onSubmit={(e) => { e.preventDefault(); generateSeats(); }}>
                                <TextField
                                    label="Dòng"
                                    type="number"
                                    value={rows}
                                    onChange={(e) => setRows(Number(e.target.value))}
                                    style={{ marginRight: '10px' }}
                                />
                                <TextField
                                    label="Cột"
                                    type="number"
                                    value={cols}
                                    onChange={(e) => setCols(Number(e.target.value))}
                                    style={{ marginRight: '10px' }}
                                />
                                <Select
                                    value={seatType}
                                    onChange={(e) => setSeatType(e.target.value)}
                                    displayEmpty
                                    style={{ marginRight: '10px' }}
                                >
                                    {seatTypeList.map((seat) => (
                                        <MenuItem key={seat.id} value={seat.id}>
                                            {seat.name}
                                        </MenuItem>
                                    ))}
                                </Select>
                                <Button type="submit" variant="contained" color="primary" sx={{ mt: 1 }}>Generate</Button>
                            </form>
                   
                {seatMatrix.length > 0 ? (
                    <div style={{ textAlign: 'center', width: calculateTotalWidth(), marginTop: '20px' }}>
                        <img src="/Images/img-screen.png" alt="Screen" style={{ width: '100%', maxWidth: calculateTotalWidth(), filter: 'brightness(80%) saturate(120%) hue-rotate(190deg)' }} />
                        <h3 style={{ marginBottom: '20px' }}>Màn hình</h3>
                        {seatMatrix.map((row, rowIndex) => (
                            <div key={rowIndex} style={{ marginBottom: gap, display: 'flex', gap, justifyContent: 'center' }}>
                                {row.map((seat, colIndex) => (
                                    <div
                                        key={colIndex}
                                        onMouseEnter={() => setHoveredSeat({ rowIndex, colIndex })}
                                        onMouseLeave={() => setHoveredSeat(null)}
                                        onClick={() => handleSeatClick(rowIndex, colIndex)}
                                        style={{
                                            width: seat.seatTypeId === getSeatTypeId(seatTypeList, "Ðôi") ? doubleSeatWidth : seatWidth,
                                            height: seatHeight,
                                            backgroundColor: seat.isSeat ? 'yellow' : 'white',
                                            border: '1px solid black',
                                            display: 'flex',
                                            alignItems: 'center',
                                            justifyContent: 'center',
                                            cursor: 'pointer',
                                            flexDirection: 'column',
                                            position: 'relative'
                                        }}
                                    >
                                        {seat.rowName}-{seat.colIndex}
                                        <div>
                                            {getSeatTypeName(seatTypeList, seat.seatTypeId)}
                                        </div>
                                        {hoveredSeat && hoveredSeat.rowIndex === rowIndex && hoveredSeat.colIndex === colIndex && (
                                            <div style={{
                                                position: 'absolute',
                                                top: '100%',
                                                left: '50%',
                                                transform: 'translateX(-50%)',
                                                backgroundColor: 'white',
                                                border: '1px solid black',
                                                zIndex: 1000
                                            }}>
                                                <Select
                                                    value={seat.seatTypeId}
                                                    onChange={(e) => handleSeatTypeChange(rowIndex, colIndex, e.target.value)}
                                                    onClick={(e) => e.stopPropagation()}
                                                    displayEmpty
                                                    style={{ width: '100px' }}
                                                >
                                                    {seatTypeList.map((seat) => (
                                                        <MenuItem key={seat.id} value={seat.id}>
                                                            {seat.name}
                                                        </MenuItem>
                                                    ))}
                                                </Select>
                                            </div>
                                        )}
                                    </div>
                                ))}
                            </div>
                        ))}
                    </div>
                ) : (
                    <div style={{ marginTop: '20px', textAlign: 'center' }}>
                        <h3>No seats available</h3>
                    </div>
                )}
            </div>
        </>
    );
}

export default GenerateSeats;
