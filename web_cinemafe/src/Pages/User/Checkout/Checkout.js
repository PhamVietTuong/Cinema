import { Box, Button, FormControl, FormHelperText, FormLabel, Grid, OutlinedInput, Step, StepLabel, Stepper, Typography } from '@mui/material';
import './Checkout.css'
import { useDispatch } from "react-redux";
import { Fragment, useState } from 'react';
import * as yup from 'yup';
import InfoTicketBooking from '../InfoTicketBooking/InfoTicketBooking';

const steps = ['THANH TOÁN', 'THÔNG TIN VÉ PHIM'];

const schema = yup.object().shape({
    fullName: yup.string().required('Vui lòng nhập họ và tên'),
    phone: yup
        .string()
        .required('Vui lòng nhập số điện thoại')
        .matches(/^[0-9]{10}$/, "Số điện thoại không hợp lệ"),
    email: yup.string().email("Email không hợp lệ").required('Vui lòng nhập email'),
});

const CustomStepIcon = (props) => {
    const { icon } = props;
    return (
        <div className='checkoutIcon' style={{}}>
            <span>{icon}</span>
        </div>
    );
};

const Checkout = () => {
    const [activeStep, setActiveStep] = useState(0);

    const handleNext = () => setActiveStep((prevActiveStep) => prevActiveStep + 1);

    const handleBack = () => setActiveStep((prevActiveStep) => prevActiveStep - 1);

    return (
        <>
            <section className='checkout checkout-customer ht'>
                <div className='container'>
                    <div class="checkout-customer-wr">
                        <Box sx={{ width: '100%' }}>
                            <Stepper activeStep={activeStep} alternativeLabel className='checkoutStepper'>
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
                            {activeStep === steps.length ? (
                                <Fragment>
                                    <Typography sx={{ mt: 2, mb: 1 }}>
                                        All steps completed - you&apos;re finished
                                    </Typography>
                                </Fragment>
                            ) : (
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
                                                                            <FormLabel sx={{ mb: 1, mt: 2 }} className="CheckoutFormLabel CheckoutIcon CheckoutHover">
                                                                                <span class="img"><img src="/Images/img-momo.png" alt="" /></span>
                                                                                <p class="text">Thanh toán qua Momo</p>
                                                                            </FormLabel>
                                                                        </FormControl>
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
                                                                        <p className="ct">NHỮNG MẢNH GHÉP CẢM XÚC 2 2D LT (P)</p>
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
                                                                        <p className="tt">Phim dành cho khán giả mọi lứa tuổi.</p>
                                                                    </div>
                                                                </div>
                                                                <div className="inner-info">
                                                                    <div className="inner-info-row cinestar-br">
                                                                        <p className="ct">Cinestar Quốc Thanh</p>
                                                                        <p className="dt">
                                                                            271 Nguyễn Trãi, Phường Nguyễn Cư Trinh, Quận 1, Thành Phố Hồ Chí Minh
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                                <div className="inner-info">
                                                                    <div className="inner-info-row time-line">
                                                                        <p className="tt">Thời gian</p>
                                                                        <p className="ct">
                                                                            <span className="time">22:05 </span>
                                                                            <span className="date">Thứ Ba 18/06/2024</span>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                                <div className="inner-info">
                                                                    <div className="inner-info-row room">
                                                                        <p className="tt">Phòng chiếu</p>
                                                                        <p className="ct">03</p>
                                                                    </div>
                                                                    <div className="inner-info-row num-ticket">
                                                                        <p className="tt">Số vé</p>
                                                                        <p className="ct">1</p>
                                                                    </div>
                                                                    <div className="inner-info-row type-ticket">
                                                                        <p className="tt">Loại vé</p>
                                                                        <p className="ct">HSSV-Người Cao Tuổi</p>
                                                                    </div>
                                                                </div>
                                                                <div className="inner-info">
                                                                    <div className="inner-info-row type-position">
                                                                        <p className="tt">Loại ghế</p>
                                                                        <p className="ct">Ghế Thường</p>
                                                                    </div>
                                                                    <div className="inner-info-row num-position">
                                                                        <p className="tt">Số ghế</p>
                                                                        <p className="ct"> A13</p>
                                                                    </div>
                                                                </div>
                                                                <div className="inner-info">
                                                                    <div className="inner-info-row corn-drink">
                                                                        <p className="tt">Bắp nước</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div className="form-footer">
                                                                <div className="inner-info">
                                                                    <div className="inner-info-row total">
                                                                        <p className="tt">Số tiền cần thanh toán</p>
                                                                        <p className="ct">45,000VND</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <button className="btn btn-submit btn--pri  opacity-30 pointer-events-none">
                                                                Thanh toán
                                                            </button>
                                                        </div>
                                                    </Grid>
                                                </Grid>
                                            )
                                    }

                                    <Box sx={{ display: 'flex', flexDirection: 'row', pt: 2 }}>
                                        <Button
                                            color="inherit"
                                            disabled={activeStep === 0}
                                            onClick={handleBack}
                                            sx={{ mr: 1 }}
                                        >
                                            Back
                                        </Button>
                                        <Box sx={{ flex: '1 1 auto' }} />

                                        <Button onClick={handleNext}>
                                            {activeStep === steps.length - 1 ? 'Finish' : 'Next'}
                                        </Button>
                                    </Box>
                                </Fragment>
                            )}
                        </Box>
                    </div>
                </div>
            </section>
        </>
    );
}

export default Checkout;

