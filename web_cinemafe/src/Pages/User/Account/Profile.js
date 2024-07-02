import Tab from '@mui/material/Tab';
import Box from '@mui/material/Box';
import { TabContext, TabList, TabPanel } from '@mui/lab';
import './Profile.css'
import PersonIcon from '@mui/icons-material/Person';
import { useState } from 'react';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import { Button, Divider, Grid, Tabs, TextField, Typography } from '@mui/material';

const Profile = () => {
    const [value, setValue] = useState('0');

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };
    return (
        <>
            <div className='container'>
                <Box sx={{ display: 'flex', minHeight: '100vh' }}>
                    <Box sx={{ width: '250px', bgcolor: '#3f51b5', color: 'white', p: 2 }} className='profileTabList'>
                        <Typography variant="h6">Name</Typography>
                        <Divider sx={{ my: 2, borderColor: 'rgba(248, 250, 252, .2)', opacity: 1 }} />
                        <Tabs
                            orientation="vertical"
                            value={value}
                            onChange={handleChange}
                            textColor="inherit"
                            indicatorColor="none"
                            sx={{
                                '& .MuiTab-root': {
                                    textTransform: 'none',
                                    alignItems: 'flex-start',
                                    justifyContent: 'flex-start',
                                    minHeight: '44.8px',
                                    height: '44.8px',
                                    '&.Mui-selected': {
                                        borderLeft: '2px solid #f3ea28',
                                        color: '#f3ea28'
                                    }
                                }
                            }}
                        >
                            <Tab label="Thông tin khách hàng" icon={<PersonIcon />} iconPosition="start" />
                            <Tab label="Lịch sử mua hàng" icon={<ShoppingCartIcon />} iconPosition="start" />
                        </Tabs>
                        <Button variant="outlined" color="inherit" sx={{ mt: 2 }}>Đăng xuất</Button>
                    </Box>
                    <Box sx={{ flexGrow: 1, p: 3 }}>
                        {value === 0 && (
                            <Box>
                                <Typography variant="h4" className='profileTypography sec-heading'>
                                    <div className='heading customer'>
                                        Thông tin khách hàng
                                    </div>
                                </Typography>
                                <Divider sx={{ my: 2 }} />
                                <Box component="form" sx={{ display: 'flex', flexDirection: 'column', gap: 2 }} className='profileBox'>
                                    <Typography variant="h4" className='profileTypography sec-heading'>
                                        <div className='heading info'>
                                            Thông tin cá nhân
                                        </div>
                                    </Typography>
                                    <Grid container spacing={2}>
                                        <Grid item xs={6}>
                                            <TextField fullWidth label="Họ và tên" defaultValue="Họ và tên" />
                                            <TextField sx={{ mt: 2 }} fullWidth label="Ngày sinh" type="date" defaultValue="2001-06-11" InputLabelProps={{ shrink: true }} />
                                        </Grid>
                                        <Grid item xs={6}>
                                            <TextField fullWidth label="Số điện thoại" defaultValue="Số điện thoại" />
                                            <TextField sx={{ mt: 2 }} fullWidth label="Email" defaultValue="Email" />
                                        </Grid>
                                    </Grid >


                                    <Button variant="contained" color="primary">Lưu thông tin</Button>
                                </Box>
                                <Divider sx={{ my: 4 }} />
                                <Box component="form" sx={{ display: 'flex', flexDirection: 'column', gap: 2 }} className='profileBox'>
                                    <Typography variant="h4" className='profileTypography sec-heading'>
                                        <div className='heading info'>
                                            Đổi mật khẩu
                                        </div>
                                    </Typography>
                                    <TextField fullWidth label="Mật khẩu cũ" type="password" />
                                    <TextField fullWidth label="Mật khẩu mới" type="password" />
                                    <TextField fullWidth label="Xác thực mật khẩu" type="password" />
                                    <Button variant="contained" color="primary">Đổi mật khẩu</Button>
                                </Box>
                            </Box>
                        )}
                        {value === 1 && (
                            <Box>
                                <Typography variant="h4">Lịch sử mua hàng</Typography>
                                {/* Add content for purchase history here */}
                            </Box>
                        )}
                    </Box>
                </Box>
            </div>
        </>
    );
}

export default Profile;