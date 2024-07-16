import { Link } from "react-router-dom";
import { ProjectionForm } from "../../Enum/ProjectionForm";
import { Button } from "react-bootstrap";
import { DOMAIN } from "../../Ustil/Settings/Config";
import './Film.css'
import { CSSTransition } from 'react-transition-group';
import { useState } from "react";

const Film = (props) => {
    return (
        <>
            <div className="web-movie-box">
                <div className="image">
                    <Link to={`/movie/${props.movie.id}`} state={{ projectionForm: props.movie.projectionForm }}>
                        <img src={`${DOMAIN}/Images/${props.movie.image}`} alt={`${props.movie.image}`} />

                        <div class="content">
                            <div class="inner">
                                <p class="name">{props.movie.name} ({props.movie.ageRestrictionName})</p>
                                <ul class="info-detail">
                                    <li class="info-item">
                                        <span class="ic">
                                            <img src="/Images/icon-tag.svg" />
                                        </span>
                                        <span class="txt">{props.movie.movieType}</span>
                                    </li>
                                    <li class="info-item">
                                        <span class="ic">
                                            <img src="/Images/icon-clock.svg" />
                                        </span>
                                        <span class="txt">{props.movie.time}'</span>
                                    </li>
                                    <li class="info-item">
                                        <span class="ic">
                                            <img src="/Images/earth-americas.svg" />
                                        </span>
                                        <span class="txt">Khác</span>
                                    </li>
                                    <li class="info-item">
                                        <span class="ic">
                                            <img src="/Images/subtitle.svg" />
                                        </span>
                                        <span class="txt">{props.movie.languages}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div className="attach">
                            <div className="type-movie">
                                {props.movie.projectionForm === ProjectionForm.Time2D ? <span className="txt">2D</span> : <span className="txt">3D</span>}
                            </div>
                            <div className="age">
                                <span className="number">
                                    {props.movie.ageRestrictionName}
                                </span>
                                <span className="txt">
                                    {props.movie.ageRestrictionAbbreviation ? props.movie.ageRestrictionAbbreviation.toUpperCase() : ''}
                                </span>
                            </div>
                        </div>
                    </Link>
                </div>

                <div className="info">
                    <Link className='name' to={`/movie/${props.movie.id}`} state={{ projectionForm: props.movie.projectionForm }}>
                        {props.movie.name}
                    </Link>

                    <div className="info-action">
                        <a className="video pointer" rel="noopener noreferrer" onClick={() => props.setShowTrailerPopup({ status: true, id: props.movie.id })}>
                            <span className="ic">
                                <img src="https://cinestar.com.vn/assets/images/icon-play-vid.svg" alt="Play Trailer"></img>
                            </span>
                            <span className="txt">Xem trailer</span>
                        </a>
                        <Link to={`/movie/${props.movie.id}`} state={{ projectionForm: props.movie.projectionForm }}><Button className="book-ticket">ĐẶT VÉ</Button></Link>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Film;