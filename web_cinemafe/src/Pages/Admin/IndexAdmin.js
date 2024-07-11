import { Drafts, Inbox, Menu } from "@mui/icons-material";
import { Box, CssBaseline, Divider, IconButton, List, ListItemButton, ListItemIcon, ListItemText, Toolbar, Typography, styled, Menu as MuiMenu, MenuItem } from "@mui/material";
import { useState } from "react";
import { Link, Outlet, useNavigate } from "react-router-dom";
import MuiDrawer from '@mui/material/Drawer';
import MuiAppBar from '@mui/material/AppBar';

import './IndexAdmin.css'
import { useDispatch, useSelector } from "react-redux";
import { LOGOUT } from "../../Redux/Actions/Type/UserType";
const drawerWidth = 240;

const openedMixin = (theme) => ({
    width: drawerWidth,
    transition: theme.transitions.create('width', {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.enteringScreen,
    }),
    overflowX: 'hidden',
});

const closedMixin = (theme) => ({
    transition: theme.transitions.create('width', {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.leavingScreen,
    }),
    overflowX: 'hidden',
    width: `calc(${theme.spacing(7)} + 1px)`,
    [theme.breakpoints.up('sm')]: {
        width: `calc(${theme.spacing(8)} + 1px)`,
    },
});

const DrawerHeader = styled('div')(({ theme }) => ({
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    padding: theme.spacing(0, 1),
    ...theme.mixins.toolbar,
}));

const AppBar = styled(MuiAppBar, {
    shouldForwardProp: (prop) => prop !== 'open',
})(({ theme, open }) => ({
    zIndex: theme.zIndex.drawer + 1,
    transition: theme.transitions.create(['width', 'margin'], {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.leavingScreen,
    }),
    ...(open && {
        marginLeft: drawerWidth,
        width: `calc(100% - ${drawerWidth}px)`,
        transition: theme.transitions.create(['width', 'margin'], {
            easing: theme.transitions.easing.sharp,
            duration: theme.transitions.duration.enteringScreen,
        }),
    }),
}));

const Drawer = styled(MuiDrawer, { shouldForwardProp: (prop) => prop !== 'open' })(
    ({ theme, open }) => ({
        width: drawerWidth,
        flexShrink: 0,
        whiteSpace: 'nowrap',
        boxSizing: 'border-box',
        ...(open && {
            ...openedMixin(theme),
            '& .MuiDrawer-paper': openedMixin(theme),
        }),
        ...(!open && {
            ...closedMixin(theme),
            '& .MuiDrawer-paper': closedMixin(theme),
        }),
    }),
);

const IndexAdmin = () => {
    const {
        loginInfo,
    } = useSelector((state) => state.UserReducer);
    const [openDrawer, setOpenDrawer] = useState(true);
    const [anchorEl, setAnchorEl] = useState(null);
    const navigate = useNavigate();
    const dispatch = useDispatch();

    const handleDrawerClose = () => {
        setOpenDrawer(false);
    };
    const handleDrawerOpen = () => {
        setOpenDrawer(true);
    };

    const handleMouseEnter = (event) => {
        setAnchorEl(event.currentTarget);
    };

    const handleMouseLeave = () => {
        setAnchorEl(null);
    };

    const handleHomePageClick = (path) => {
        navigate(path);
        setAnchorEl(null);
    };

    const open = Boolean(anchorEl);

    return (
        <>
            <Box sx={{ display: 'flex' }}>
                <CssBaseline />
                <AppBar position="fixed" open={openDrawer}>
                    <Toolbar className="IndexAdminToolbar">
                        <IconButton
                            color="inherit"
                            aria-label="open drawer"
                            onClick={handleDrawerOpen}
                            edge="start"
                            sx={{
                                marginRight: 5,
                                ...(openDrawer && { display: 'none' }),
                            }}
                        >
                            <Menu />
                        </IconButton>
                        <Typography variant="h6" noWrap component="div" className="IndexAdminTypography">
                            Mini variant drawer
                        </Typography>
                        <Box sx={{ flexGrow: 1 }} />
                        <Typography
                            variant="h6"
                            noWrap
                            component="div"
                            className="IndexAdminTypography"
                            onMouseEnter={handleMouseEnter}
                        >
                            {loginInfo?.fullName}
                        </Typography>
                        <MuiMenu
                            anchorEl={anchorEl}
                            open={open}
                            onClose={handleMouseLeave}
                            MenuListProps={{ onMouseLeave: handleMouseLeave }}
                        >
                            <MenuItem onClick={() => handleHomePageClick('/')}>Trang chủ</MenuItem>
                            <MenuItem onClick={() => {
                                dispatch({
                                    type: LOGOUT,
                                })
                            }}>Đăng xuất</MenuItem>
                        </MuiMenu>
                    </Toolbar>
                </AppBar>
                <Drawer variant="permanent" open={openDrawer} className="IndexAdminDrawer">
                    <DrawerHeader onClick={handleDrawerClose} className="IndexAdminDrawerHeader">
                        Admin
                    </DrawerHeader>
                    <Divider />
                    <List>
                        <Link to="Movie">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Phim" />
                            </ListItemButton>
                        </Link>
                        <Link to="AgeRestriction">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Giới hạng độ tuổi" />
                            </ListItemButton>
                        </Link>

                        <Link to="TicketType">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Loại vé" />
                            </ListItemButton>
                        </Link>

                        <Link to="MovieType">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Thể loại phim" />
                            </ListItemButton>
                        </Link>

                        <Link to="SeatType">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Loại ghế" />
                            </ListItemButton>
                        </Link>

                        <Link to="UserType">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Loại người dùng" />
                            </ListItemButton>
                        </Link>

                        <Link to="theater">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Rạp" />
                            </ListItemButton>
                        </Link>

                        <Link to="revenue">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Thống kê" />
                            </ListItemButton>
                        </Link>
                    </List>
                </Drawer>
                <Box component="main" sx={{ flexGrow: 1, p: 3 }} style={{ backgroundColor: '#ebeef2' }}>
                    <DrawerHeader />
                    <Outlet />
                </Box>
            </Box>
        </>
    );
}

export default IndexAdmin;