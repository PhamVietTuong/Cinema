import { DOMAIN } from '../../../Ustil/Settings/Config';
import './FoodAndDrink.css'
const FoodAndDrink = (props) => {
    return ( 
        <>
            <section className="sec-dt-food">
                <div className="dt-food">
                    <div className="container">
                        <div className="dt-food-wr">
                            <div className="dt-food-heading sec-heading" data-aos="fade-up">
                                <h2 className="heading">Chọn bắp nước</h2>
                            </div>
                            <div className="dt-food-body">
                                <div className="dt-combo dt-item" data-aos="fade-up">
                                    <div className="combo-tile">
                                        <div className="title">COMBO 2 NGĂN</div>
                                    </div>
                                    <div className="combo-content">
                                        <div className="combo-list row">
                                            {props.combo.map((comboItem, comboIndex) => (
                                                <div className="combo-item col col-4">
                                                    <div className="food-box">
                                                        <div className="img">
                                                            <div className="image">
                                                                {" "}
                                                                <img
                                                                    src={`${DOMAIN}/Images/${comboItem.image}`}
                                                                    alt=""
                                                                />
                                                            </div>
                                                        </div>
                                                        <div className="content">
                                                            <div className="content-top">
                                                                <p className="name sub-title cursor-pointer">
                                                                    {comboItem.name}
                                                                </p>
                                                                <div className="desc">
                                                                    <p>
                                                                        {comboItem.description}
                                                                    </p>
                                                                </div>
                                                                <div className="price sub-title">
                                                                    <p>{comboItem.price.toLocaleString("en-US").replace(/,/g, ".")} đ </p>
                                                                </div>
                                                            </div>
                                                            <div className="content-bottom">
                                                                <div className="count">
                                                                    <div className="count-btn count-minus">
                                                                        <i className="fas fa-minus icon" />
                                                                    </div>
                                                                    <p className="count-number">0</p>
                                                                    <div className="count-btn count-plus">
                                                                        <i className="fas fa-plus icon" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            ))}
                                            {/* <div className="combo-item col col-4">
                                                <div className="food-box">
                                                    <div className="img">
                                                        <div className="image">
                                                            {" "}
                                                            <img
                                                                src="https://api-website.cinestar.com.vn/media/.thumbswysiwyg/pictures/Cinestar/BAP-2-NGAN_COMBO-SOLO.png?rand=1711034558"
                                                                alt=""
                                                            />
                                                        </div>
                                                    </div>
                                                    <div className="content">
                                                        <div className="content-top">
                                                            <p className="name sub-title cursor-pointer">
                                                                Combo Solo 2 Ngăn - VOL
                                                            </p>
                                                            <div className="desc">
                                                                <p>
                                                                    1 Coke 32oz - V + 1 Bắp 2 Ngăn 64OZ PM + CARAMEN{" "}
                                                                </p>
                                                            </div>
                                                            <div className="price sub-title">
                                                                <p>119,000 đ </p>
                                                            </div>
                                                        </div>
                                                        <div className="content-bottom">
                                                            <div className="count">
                                                                <div className="count-btn count-minus">
                                                                    <i className="fas fa-minus icon" />
                                                                </div>
                                                                <p className="count-number">0</p>
                                                                <div className="count-btn count-plus">
                                                                    <i className="fas fa-plus icon" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div className="combo-item col col-4">
                                                <div className="food-box">
                                                    <div className="img">
                                                        <div className="image">
                                                            {" "}
                                                            <img
                                                                src="https://api-website.cinestar.com.vn/media/.thumbswysiwyg/pictures/Cinestar/BAP-2-NGAN_COMBO-PARTY.png?rand=1711034558"
                                                                alt=""
                                                            />
                                                        </div>
                                                    </div>
                                                    <div className="content">
                                                        <div className="content-top">
                                                            <p className="name sub-title cursor-pointer">
                                                                Combo Party 2 Ngăn - VOL
                                                            </p>
                                                            <div className="desc">
                                                                <p>
                                                                    4 Coke 22oz - V + 2 Bắp 2 Ngăn 64OZ PM + CARAMEN{" "}
                                                                </p>
                                                            </div>
                                                            <div className="price sub-title">
                                                                <p>259,000 đ </p>
                                                            </div>
                                                        </div>
                                                        <div className="content-bottom">
                                                            <div className="count">
                                                                <div className="count-btn count-minus">
                                                                    <i className="fas fa-minus icon" />
                                                                </div>
                                                                <p className="count-number">0</p>
                                                                <div className="count-btn count-plus">
                                                                    <i className="fas fa-plus icon" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div className="combo-item col col-4">
                                                <div className="food-box">
                                                    <div className="img">
                                                        <div className="image">
                                                            {" "}
                                                            <img
                                                                src="https://api-website.cinestar.com.vn/media/.thumbswysiwyg/pictures/Cinestar/BAP-2-NGAN_COMBO-COUPLE.png?rand=1711034558"
                                                                alt=""
                                                            />
                                                        </div>
                                                    </div>
                                                    <div className="content">
                                                        <div className="content-top">
                                                            <p className="name sub-title cursor-pointer">
                                                                Combo Couple 2 Ngăn - VOL
                                                            </p>
                                                            <div className="desc">
                                                                <p>
                                                                    2 Coke 32oz - V + 1 Bắp 2 Ngăn 64OZ PM + CARAMEN{" "}
                                                                </p>
                                                            </div>
                                                            <div className="price sub-title">
                                                                <p>129,000 đ </p>
                                                            </div>
                                                        </div>
                                                        <div className="content-bottom">
                                                            <div className="count">
                                                                <div className="count-btn count-minus">
                                                                    <i className="fas fa-minus icon" />
                                                                </div>
                                                                <p className="count-number">0</p>
                                                                <div className="count-btn count-plus">
                                                                    <i className="fas fa-plus icon" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> */}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </>
     );
}
 
export default FoodAndDrink;