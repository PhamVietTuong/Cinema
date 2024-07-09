import { Typography } from "@mui/material";
import React from "react";

const HighlightedText = ({ label, text }) => {
    return (
        <Typography variant="body1" sx={{ fontWeight: 'bold', color: '#333' }}>
            {label}: <span style={{ fontWeight: 'normal', color: text.includes(-1)? 'red' : 'black' }}>{text}</span>
        </Typography>
    );
};

export default HighlightedText;