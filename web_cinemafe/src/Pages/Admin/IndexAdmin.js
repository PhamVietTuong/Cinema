import { Drafts,  Inbox, Menu } from "@mui/icons-material";
import { Box, CssBaseline, Divider, IconButton, List, ListItemButton, ListItemIcon, ListItemText, Toolbar, Typography, styled, useTheme } from "@mui/material";
import { useState } from "react";
import { Link, Outlet } from "react-router-dom";
import MuiDrawer from '@mui/material/Drawer';
import MuiAppBar from '@mui/material/AppBar';

import './IndexAdmin.css'
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
    const [openDrawer, setOpenDrawer] = useState(true);

    const handleDrawerClose = () => {
        setOpenDrawer(false);
    };
    const handleDrawerOpen = () => {
        setOpenDrawer(true);
    };
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
                    </Toolbar>
                </AppBar>
                <Drawer variant="permanent" open={openDrawer} className="IndexAdminDrawer">
                    <DrawerHeader onClick={handleDrawerClose} className="IndexAdminDrawerHeader">
                        Admin
                    </DrawerHeader>
                    <Divider />
                    <List>
                        <Link to="AgeRestriction">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="AgeRestriction" />
                            </ListItemButton>
                        </Link>

                        <Link to="TicketType">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="TicketType" />
                            </ListItemButton>
                        </Link>

                        <Link to="MovieType">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="MovieType" />
                            </ListItemButton>
                        </Link>

                        <Link to="SeatType">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="SeatType" />
                            </ListItemButton>
                        </Link>

                        <Link to="UserType">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="UserType" />
                            </ListItemButton>
                        </Link>

                        <Link to="theater">
                            <ListItemButton>
                                <ListItemIcon>
                                    <Inbox />
                                </ListItemIcon>
                                <ListItemText primary="Theater" />
                            </ListItemButton>
                        </Link>
                    </List>
                </Drawer>
                <Box component="main" sx={{ flexGrow: 1, p: 3 }} style={{ backgroundColor: '#ebeef2'}}>
                    <DrawerHeader />
                    <Outlet />
                </Box>
            </Box>
        </>
    );
}

export default IndexAdmin;