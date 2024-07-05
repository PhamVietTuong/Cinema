import { Box, Button, FormControl, FormHelperText, FormLabel, Grid, OutlinedInput, Step, StepLabel, Stepper, Typography } from '@mui/material';
import './Checkout.css'
import { useDispatch, useSelector } from "react-redux";
import { Fragment, useEffect, useState } from 'react';
import * as yup from 'yup';
import InfoTicketBooking from '../InfoTicketBooking/InfoTicketBooking';
import { useNavigate } from 'react-router-dom';
import { TicketBooking } from '../../../Redux/Actions/CinemasAction';
import moment from 'moment';
import "moment/locale/vi";

const steps = ['THANH TOÁN', 'THÔNG TIN VÉ PHIM'];

const CustomStepIcon = (props) => {
    const { icon } = props;
    return (
        <div className='checkoutIcon' style={{}}>
            <span>{icon}</span>
        </div>
    );
};

const formatCurrency = (value) => {
    if (!value) return 0; 
    return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
};

const formatDate = (dateString) => {
    if (!dateString) return ""; 
    const formattedDate = moment(dateString).locale("vi").format("dddd DD/MM/yyyy");
    return formattedDate.charAt(0).toUpperCase() + formattedDate.slice(1);
};

const Checkout = () => {
    const {
        invoiceDTO,
        movieInfoBooking,
    } = useSelector((state) => state.CinemasReducer);
    const [selectedPaymentMethod, setSelectedPaymentMethod] = useState('');
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const [activeStep, setActiveStep] = useState(0);

    const handleCheckout = () => {
        dispatch(TicketBooking(invoiceDTO, selectedPaymentMethod))
    }

    const handleActiveCheckout = (method) => {
        setSelectedPaymentMethod(method);
    }
    return (
        <>
            <section className='checkout checkout-customer'>
                <div className='container'>
                    <div class="checkout-customer-wr">
                        <Box sx={{ width: '100%' }}>
                            <Stepper activeStep={activeStep} alternativeLabel className='checkoutStepper' orientation="horizontal">
                                {steps.map((label, index) => {
                                    const stepProps = {};
                                    const labelProps = { StepIconComponent: CustomStepIcon };
                                    return (
                                        <Step key={label} {...stepProps}>
                                            <StepLabel {...labelProps} className='checkoutStepLabel'>{label}</StepLabel  >
                                        </Step>
                                    );
                                })}
                            </Stepper>
                            <Fragment>
                                {
                                    activeStep === 2 ? (
                                        <>
                                            <InfoTicketBooking />
                                        </>
                                    )
                                        :
                                        (
                                            <Grid container spacing={2}>
                                                <Grid item xs={6}>
                                                    <Typography sx={{ mt: 2, mb: 1 }}>
                                                        {
                                                            activeStep === 0 && (
                                                                <>
                                                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="CheckoutFormControl">
                                                                        <FormLabel 
                                                                            sx={{ mb: 1, mt: 2 }} 
                                                                            className={`CheckoutFormLabel CheckoutIcon CheckoutHover ${selectedPaymentMethod === 'Momo' ? 'active' : ''}`}
                                                                            onClick={() => handleActiveCheckout('Momo')}
                                                                        >
                                                                            <span class="img"><img src="/Images/img-momo.png" alt="Momo" /></span>
                                                                            <p class="text">Thanh toán qua Momo</p>
                                                                        </FormLabel>
                                                                    </FormControl>

                                                                    <FormControl sx={{ m: 1 }} variant="outlined" fullWidth className="CheckoutFormControl">
                                                                        <FormLabel
                                                                            sx={{ mb: 1, mt: 2 }}
                                                                            className={`CheckoutFormLabel CheckoutIcon CheckoutHover ${selectedPaymentMethod === 'VNPay' ? 'active' : ''}`}
                                                                            onClick={() => handleActiveCheckout('VNPay')}
                                                                        >
                                                                            <span class="img"><img src="/Images/img-vnpay.png" alt="VNPay" /></span>
                                                                            <p class="text">Thanh toán qua VNPay</p>
                                                                        </FormLabel>
                                                                    </FormControl>
                                                                    <div className='CheckoutButtonPayment'>
                                                                        <Button className="btn btn-submit btn--pri  opacity-30 pointer-events-none" fullWidth>
                                                                            Quay lại
                                                                        </Button>
                                                                        <Button className="btn btn-submit btn--pri  opacity-30 pointer-events-none" fullWidth onClick={handleCheckout}>
                                                                            Thanh toán
                                                                        </Button>
                                                                    </div>
                                                                </>
                                                            )
                                                        }
                                                    </Typography>
                                                </Grid>
                                                <Grid item xs={6}>
                                                    <div className="form-checkout-cus">
                                                        <div className="form-main">
                                                            <div className="inner-info">
                                                                <div className="inner-info-row bill-coundown-custom">
                                                                    <p className="ct">{movieInfoBooking?.movieName}</p>
                                                                    <div className="bill-coundown-custom">
                                                                        <p className="txt">Thời gian giữ vé:</p>
                                                                        <div className="bill-coundown !w-[68px]">
                                                                            <div className="bill-time">
                                                                                <p id="timerCheckout">00: 00 </p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div className="inner-info">
                                                                <div className="inner-info-row">
                                                                    <p className="tt">{movieInfoBooking?.ageRestrictionDescription}</p>
                                                                </div>
                                                            </div>
                                                            <div className="inner-info">
                                                                <div className="inner-info-row cinestar-br">
                                                                    <p className="ct">{movieInfoBooking?.theaterName}</p>
                                                                    <p className="dt">
                                                                        {movieInfoBooking?.theaterAddress}                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div className="inner-info">
                                                                <div className="inner-info-row time-line">
                                                                    <p className="tt">Thời gian</p>
                                                                    <p className="ct">
                                                                        <span className="time">{moment(movieInfoBooking?.startTime).format("HH:mm")} </span>
                                                                        <span className="date">{formatDate(movieInfoBooking?.startTime)}</span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div className="inner-info">
                                                                <div className="inner-info-row room">
                                                                    <p className="tt">Phòng chiếu</p>
                                                                    <p className="ct">{movieInfoBooking?.roomName}</p>
                                                                </div>
                                                                <div className="inner-info-row num-ticket">
                                                                    <p className="tt">Số vé</p>
                                                                    <p className="ct">{movieInfoBooking?.seatName?.split(",").length}</p>
                                                                </div>
                                                                <div className="inner-info-row type-ticket">
                                                                    <p className="tt">Loại vé</p>
                                                                    <p className="ct">{movieInfoBooking?.ticketTypeName}</p>
                                                                </div>
                                                            </div>
                                                            <div className="inner-info">
                                                                <div className="inner-info-row type-position">
                                                                    <p className="tt">Loại ghế</p>
                                                                    <p className="ct">Ghế Thường</p>
                                                                </div>
                                                                <div className="inner-info-row num-position">
                                                                    <p className="tt">Số ghế</p>
                                                                    <p className="ct"> {movieInfoBooking?.seatName}</p>
                                                                </div>
                                                            </div>
                                                            <div className="inner-info">
                                                                <div className="inner-info-row corn-drink">
                                                                    <p className="tt">Bắp nước</p>
                                                                    {movieInfoBooking?.combo?.map((item) => (
                                                                        <p key={item.name} className="ct">
                                                                            {item.count} {item.name}
                                                                        </p>
                                                                    ))}
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div className="form-footer">
                                                            <div className="inner-info">
                                                                <div className="inner-info-row total">
                                                                    <p className="tt">Số tiền cần thanh toán</p>
                                                                    <p className="ct">{formatCurrency(movieInfoBooking?.totalPrice)}</p>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </Grid>
                                            </Grid>
                                        )
                                }
                            </Fragment>
                        </Box>
                    </div>
                </div>
            </section>
        </>
    );
}

export default Checkout;

