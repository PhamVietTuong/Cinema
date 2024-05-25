process.env.TZ ="Asia/HoChiMinh"
const PORT = process.env.PORT || 3000;
const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);

const configureSocket = require('./socket')

const movie = require('./controllers/movie');
const ticket = require('./controllers/ticket');
const theater = require('./controllers/theater');
const showtime=require('./controllers/showtime');
const room =require('./controllers/room');
const seat = require('./controllers/seat');


app.use(express.json());
app.use('/movie', movie);
app.use('/ticket', ticket);
app.use('/theater', theater);
app.use('/showtime', showtime);
app.use('/room', room);
app.use('/seat', seat);



configureSocket(server);

server.listen(PORT, async () => {
  console.log(`Server is running on port ${PORT}`);
});