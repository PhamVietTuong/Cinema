const socketIo = require('socket.io');
const db = require('./db');
const { json } = require('express');

function configureSocket(server) {
    const io = socketIo(server);

    const connected = {
        's_2-room_2': { 'abc': { seat_id: [36, 25, 37], time: null } },
        's_1-room_1': { 'abca': { seat_id: [6, 9, 10, 17], time: null } }

    };
    io.on('connection', (socket) => {
        console.log('Một người dùng đã kết nối');
        var key_s_r;
        socket.on('userConnected', (data) => {
            const { showtime_id, room_id } = data;
            key_s_r = `s_${showtime_id}-room_${room_id}`;
            joinRoom(socket, key_s_r, connected);

            console.log(connected);

            const seats = getWaitingSeatId(key_s_r, connected);
            socket.emit('getWaitingSeat', seats);
        });

        socket.on('changeShowtime', (data) => {
            leaveRoom(socket, key_s_r, connected);

            const { showtime_id, room_id } = data;
            key_s_r = `s_${showtime_id}-room_${room_id}`;
            joinRoom(socket, key_s_r, connected);

            console.log(connected);

            const seats = getWaitingSeatId(key_s_r, connected);
            socket.emit('getWaitingSeat', seats);
        });

        socket.on('selectSeat', async (data) => {
            const { seat_id, showtime_id } = data;
            //khởi tạo biến trạng thái ở trạng thái trống, trống =1, chờ =3, đã bán = 0
            var state = 1;
            //kiểm tra có ai chọn chưa
            for (const socketId in connected[key_s_r]) {
                if (connected[key_s_r][socketId].seat_id.includes(seat_id)) {
                    //chuyển ghế vào trạng thái đang chờ
                    state = 3;
                    break;
                }
            }
            //kiểm tra thêm đã được mua chưa
            if (state === 1) {
                try {
                    const [results] = await db.query(
                        'SELECT COUNT(*) AS count FROM tickets WHERE seat_id = ? AND showtime_id = ?',
                        [seat_id, showtime_id]
                    );

                    if (results[0].count > 0) {
                        state = 0;
                    }
                } catch (error) {
                    console.error('Lỗi khi truy vấn cơ sở dữ liệu:', error);
                }
            }

            if (state == 1) {
                connected[key_s_r][socket.id].seat_id.push(seat_id);
                resetSeatTimer(key_s_r, socket, connected);
                socket.broadcast.to(key_s_r).emit("updateSeat", { "seat_id": [seat_id], "state": 3 });
                console.log(connected);
                console.log(connected[key_s_r][socket.id].seat_id);
            }
            socket.emit("checkForEmptySeats", { "seat_id": seat_id, state: state })
        })

        socket.on('deSelectSeat', (data) => {
            const { seat_id } = data;
            const seatIndex = connected[key_s_r][socket.id].seat_id.indexOf(seat_id);
            if (seatIndex !== -1) {
                // Xóa seat_id khỏi mảng seat_id sử dụng splice
                connected[key_s_r][socket.id].seat_id.splice(seatIndex, 1);

                resetSeatTimer(key_s_r, socket, connected);
                socket.broadcast.to(key_s_r).emit("updateSeat", { "seat_id": [seat_id], "state": 1 });

                console.log(connected);
                console.log(connected[key_s_r][socket.id].seat_id);

            }
        });

        socket.on('disconnect', () => {
            if (connected[key_s_r][socket.id]) {



                leaveRoom(socket, key_s_r, connected);
                console.log(connected);
            }
        });
    });
}

// Thêm kết nối và tham gia phòng
function joinRoom(socket, key_s_r, connected) {
    if (!connected[key_s_r]) {
        connected[key_s_r] = {};
    }
    if (!connected[key_s_r][socket.id]) {
        connected[key_s_r][socket.id] = { "seat_id": [], "time": null };
    }
    socket.join(key_s_r);
}

// Xóa kết nối và rời khỏi phòng
function leaveRoom(socket, key_s_r, connected) {
    if (connected[key_s_r] && connected[key_s_r][socket.id]) {

        //gui ds ghe dang chon
        var ids = connected[key_s_r][socket.id].seat_id;
        socket.broadcast.to(key_s_r).emit("updateSeat", { "seat_id": ids, "state": 1 });

        delete connected[key_s_r][socket.id];
        socket.leave(key_s_r);

        const numberOfConnections = Object.keys(connected[key_s_r]).length;
        if (numberOfConnections === 0) {
            delete connected[key_s_r];
        }
    }
}

//lấy danh sách ghế đang được chọn bởi các kết nối khác
function getWaitingSeatId(key_s_r, connected) {
    const seat_ids = [];
    if (connected[key_s_r]) {
        for (const socketId in connected[key_s_r]) {
            if (connected[key_s_r][socketId].seat_id) {
                seat_ids.push(...connected[key_s_r][socketId].seat_id);
            }
        }
    }
    return Array.from(new Set(seat_ids));
}

//cài đặt thời gian giữ ghế
function resetSeatTimer(key_s_r, socket, connected) {
    if (connected[key_s_r][socket.id].time) {
        clearTimeout(connected[key_s_r][socket.id].time);
    }
    if (connected[key_s_r][socket.id].seat_id.length > 0) {

        connected[key_s_r][socket.id].time = setTimeout(() => {
            if (connected[key_s_r] && connected[key_s_r][socket.id]) {
                const seat_ids = connected[key_s_r][socket.id].seat_id;
                delete connected[key_s_r][socket.id];
                if (Object.keys(connected[key_s_r]).length === 0) {
                    delete connected[key_s_r];
                }
                console.log(connected);
                socket.broadcast.to(key_s_r).emit("updateSeat", { "seat_id": seat_ids, "state": 1 });
                socket.emit("resetScreen");
                console.log(`Removed seats for ${socket.id} due to inactivity.`);
            }
        }, 5000);
    }

}

module.exports = configureSocket;
