import { useEffect, useState } from 'react';
import './BookTicket.css'
import { Accordion, AccordionDetails, AccordionSummary, Fade, Icon, SvgIcon, Typography } from '@mui/material';
import { ExpandMore } from '@mui/icons-material';
import { DOMAIN } from '../../Ustil/Settings/Config';
import { Link } from 'react-router-dom';
import moment from 'moment';
import { ShowTimeType } from '../../Enum/ShowTimeType';

const BookTicket = (props) => {
    const [expanded, setExpanded] = useState("panel0");
    const [dates, setDates] = useState([]);
    const [activeDateIndex, setActiveDateIndex] = useState(0);

    const handleChange = (panel) => (event, isExpanded) => {
        setExpanded(isExpanded ? panel : false);
    };

    useEffect(() => {
        const currentDate = new Date();
        const generatedDates = [];
        for (let i = 0; i < 3; i++) {
            const date = new Date();
            date.setDate(currentDate.getDate() + i);
            generatedDates.push(date);
        }
        setDates(generatedDates);
    }, [props.bookTicket.schedules]);

    const handleDateSelection = (selectedDate) => {
        const selectedDateOnly = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), selectedDate.getDate());
        return dates.findIndex(date => {
            const dateOnly = new Date(date.getFullYear(), date.getMonth(), date.getDate());
            return dateOnly.getTime() === selectedDateOnly.getTime();
        });
    };

    return (
        <>
            <div className="movies-wr">
                <div className="movies-img">
                    <Link to={`movie/${props.bookTicket.id}`} className="inner">
                        <img src={`${DOMAIN}/Images/${props.bookTicket.image}`} alt={`${props.bookTicket.image}`}></img>
                    </Link>
                </div>
                <div className="movies-content">
                    <h3 className="movies-name">
                        <Link to={`movie/${props.bookTicket.id}`} className="inner">
                            {props.bookTicket.name} {props.bookTicket.showTimeTypeName} {`(${props.bookTicket.ageRestrictionName})`}
                        </Link>
                    </h3>
                    <div className="movies-type is-desktop">
                        <ul>
                            <li>
                                <img src="/Images/icon-tag.svg" alt="" />
                                <span className="txt">{props.bookTicket.movieType}</span>
                            </li>
                            <li>
                                <img src="/Images/icon-clock.svg" alt="" />
                                <span className="txt">{props.bookTicket.time}</span>
                            </li>
                            <li>
                                <img src="/Images/earth-americas.svg" alt="" />
                                <span className="txt">Khác</span>
                            </li>
                            <li>
                                <img src="/Images/subtitle.svg" alt="" />
                                <span className="txt">Phụ đề</span>
                            </li>
                            <li>
                                <img src="/Images/user-check.svg" alt="" />
                                <i className="fa-regular fa-user-check" />
                                <span className="txt">
                                    {props.bookTicket.ageRestrictionName}: {props.bookTicket.ageRestrictionDescription}
                                </span>
                            </li>
                        </ul>
                    </div>
                    {
                        props.bookTicket.schedules.length === 0 ?
                            (
                                <div className="movies-rp-noti">
                                    <img src="/Images/movie-updating.png" alt="" />
                                    Chưa có suất chiếu
                                </div>
                            )
                            :
                            (
                                props.bookTicket.schedules.map((schedule, index) => (
                                    <Accordion key={index} expanded={expanded === `panel${index}`} onChange={handleChange(`panel${index}`)} className='BKAccordion'>
                                        <AccordionSummary
                                            expandIcon={<ExpandMore className='BKExpandMore' />}
                                            aria-controls={`panel${index}-content`}
                                            id={`panel${index}-header`}
                                            className='BKAccordionSummary'
                                        >
                                            <Typography 
                                                sx={{ flexShrink: 0 }} 
                                                className='BKTypographyDate' 
                                                
                                            >
                                                Ngày: {new Date(schedule.date).toLocaleDateString()}
                                            </Typography>
                                        </AccordionSummary>
                                        <AccordionDetails className='BKAccordionDetails'>
                                            <Typography className='BKTypographyDes'>
                                                {schedule.theaters.map(theater => (
                                                    <>
                                                        {theater.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Standard).length > 0 && (
                                                            <div className='movies-rp-item'>
                                                                <p className="movies-rp-title">Standard</p>
                                                                <div className="movies-time">
                                                                    <div className="movies-time-slider">
                                                                        <div className="swiper-container">
                                                                            <div className="swiper rows">
                                                                                <div className="swiper-wrapper">
                                                                                    {
                                                                                        theater.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Standard).map(showTime => (
                                                                                            <div key={showTime.showTimeId} className="swiper-slide col">
                                                                                                <Link to={`/movie/${props.bookTicket.id}/?id=${theater.theaterId}&show_time=${showTime.showTimeId}&room=${showTime.roomId}`}
                                                                                                    state={{
                                                                                                        selectedShowTime: moment(new Date(showTime.startTime)).format("HH:mm"),
                                                                                                        selectedheaterName: theater.theaterName,
                                                                                                        projectionForm: props.bookTicket.projectionForm,
                                                                                                        activeDateIndex: handleDateSelection(new Date(showTime.startTime))
                                                                                                    }} 
                                                                                                    className="movies-time-item"
                                                                                                    >
                                                                                                    {moment(new Date(showTime.startTime)).format("HH:mm")}
                                                                                                </Link>
                                                                                            </div>
                                                                                        )
                                                                                        )
                                                                                    }
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        )}
                                                        {theater.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Deluxe).length > 0 && (
                                                            <div className='movies-rp-item'>
                                                                <p className="movies-rp-title">Deluxe</p>
                                                                <div className="movies-time">
                                                                    <div className="movies-time-slider">
                                                                        <div className="swiper-container">
                                                                            <div className="swiper rows">
                                                                                <div className="swiper-wrapper">
                                                                                    {
                                                                                        theater.showTimes.filter(timeItem => timeItem.showTimeType === ShowTimeType.Deluxe).map(showTime => (
                                                                                            <div key={showTime.showTimeId} className="swiper-slide col">
                                                                                                <Link to={`/movie/${props.bookTicket.id}/?id=${theater.theaterId}&show_time=${showTime.showTimeId}&room=${showTime.roomId}`}
                                                                                                    state={{
                                                                                                        selectedShowTime: moment(new Date(showTime.startTime)).format("HH:mm"),
                                                                                                        selectedheaterName: theater.theaterName,
                                                                                                        projectionForm: props.bookTicket.projectionForm,
                                                                                                        activeDateIndex: activeDateIndex
                                                                                                    }} className="movies-time-item">
                                                                                                    {moment(new Date(showTime.startTime)).format("HH:mm")}
                                                                                                </Link>
                                                                                            </div>
                                                                                        ))
                                                                                    }
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        )}
                                                    </>
                                                )
                                                )}
                                            </Typography>
                                        </AccordionDetails>
                                    </Accordion>
                                ))
                            )
                    }
                </div>
            </div>
        </>
    );
}

export default BookTicket;