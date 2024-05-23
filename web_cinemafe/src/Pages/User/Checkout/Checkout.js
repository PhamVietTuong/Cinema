import { Table } from "react-bootstrap";
import './Checkout.css'
import { useDispatch } from "react-redux";
// import { datGheAction } from "../../Redux/Actions/TicketAction";

const Checkout = () => {
    const dispatch = useDispatch();
    
    const renderSeats = () => {
        return (
            <>
                <div className="seat-indicator-scroll">
                    <div className="seat-block relative --sm">
                        <div className="seat-screen">
                            <img src="./Images/img-screen.png" />
                            <div className="txt">
                                Màn hình
                            </div>
                        </div>
                        <div className="seat-main">
                            <div className="seat-table">
                                <Table className="seat-table-inner">
                                    <tbody>
                                        <tr>
                                            <td className="seat-name-row">
                                                A
                                            </td>
                                            <td className="seat-td"
                                                onClick={() => {
                                                    // dispatch(datGheAction("A1", 111));
                                                }}
                                            >
                                                <p>1</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>2</p>

                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>3</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>4</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>5</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>6</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td className="seat-name-row">
                                                B
                                            </td>
                                            <td className="seat-td">
                                                <p>1</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>2</p>

                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>3</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>4</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>5</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>6</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td className="seat-name-row">
                                                C
                                            </td>
                                            <td className="seat-td">
                                                <p>1</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>2</p>

                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>3</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>4</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>5</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>6</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td className="seat-name-row">
                                                D
                                            </td>
                                            <td className="seat-td">
                                                <p>1</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>2</p>

                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>3</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>4</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>5</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>6</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td className="seat-name-row">
                                                E
                                            </td>
                                            <td className="seat-td">
                                                <p>1</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>2</p>

                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>3</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>4</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>5</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                            <td className="seat-td">
                                                <p>6</p>
                                                <img src="./Images/single-seat.png" alt="" />
                                            </td>
                                        </tr>
                                    </tbody>

                                </Table>
                            </div>

                        </div>

                    </div>

                </div>
            </>

        );
    };

    return (
        <>
            <div>
                <div className="grid grid-cols-12">
                    <div className="col-span-9">
                        <div className="flex flex-col items-center mt-5">
                            <div
                                className="bg-green-300 rounded-lg"
                                style={{ width: "80%", height: 30 }}
                            >
                                <h1
                                    className="text-white text-center"
                                    style={{ lineHeight: "30px" }}
                                >
                                    Màn hình
                                </h1>
                            </div>
                            {/* <div className={`${style["trapezoid"]} text-center`}></div> */}
                            <div className="mt-5">{renderSeats()}</div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Checkout;

