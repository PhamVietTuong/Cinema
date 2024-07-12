import { Typography } from "@mui/material";
import React from "react";

const HighlightedText = ({ label, text }) => {
    let textColor = '#333';
    if (text === 'Đã chiếu' || text === -1) {
        textColor = 'red';
    } else if (text === 'Đang chiếu') {
        textColor = 'green'; 
    }
    return (
        <Typography variant="body1" sx={{ fontWeight: 'bold', color: '#333' }}>
            {label}: <span style={{ fontWeight: 'normal', color: textColor }}>{text}</span>
        </Typography>
    );
};

export default HighlightedText;