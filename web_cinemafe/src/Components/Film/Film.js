import { Link } from "react-router-dom";
import { ProjectionForm } from "../../Enum/ProjectionForm";
import { Button } from "react-bootstrap";
import { DOMAIN } from "../../Ustil/Settings/Config";
import './Film.css'

const Film = (props) => {
    return (
        <>
            <div className="web-movie-box">
                <div className="image">
                    <Link to={`detail/${props.movie.id}`} state={{ projectionForm: props.movie.projectionForm }}>
                        <img src={`${DOMAIN}/Images/${props.movie.image}`} alt={`${props.movie.image}`}/>
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
                    <Link className='name' to={`detail/${props.movie.id}`} state={{ projectionForm: props.movie.projectionForm }}>
                        {props.movie.name}
                    </Link>

                    <div className="info-action">
                        <Link className='video pointer' to={props.movie.trailer}>
                            <span className="ic">
                                <img src="https://cinestar.com.vn/assets/images/icon-play-vid.svg" alt=""></img>
                            </span>
                            <span className="txt">
                                Xem trailer
                            </span>
                        </Link>
                        <Button variant="warning">ĐẶC VÉ</Button>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Film;