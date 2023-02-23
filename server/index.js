//jshint esversion:6
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");
require("dotenv").config();

// init
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);

var io = require("socket.io")(server);

// middlewares
app.use(express.json());

// mongoose connection
mongoose
  .connect(
    `mongodb+srv://${process.env.DB_NAME}:${process.env.DB_PASS}@cluster0.sbukare.mongodb.net/?retryWrites=true&w=majority`
  )
  .then(() => {
    console.log("database connected successfully");
  })
  .catch((e) => {
    console.log(e);
  });

// socket io
io.on("connection", (socket) => {
  console.log("socket.io connected");

  socket.on("createRoom", async ({ nickname }) => {
    console.log(nickname);

    try {
      let room = new Room();

      let player = {
        socketID: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;
      room = await room.save();

      const roomId = room._id.toString();

      socket.join(roomId);
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room Id.");
        return;
      }


      let room = await Room.findById(roomId);

      if (room.isJoin) {
        let player = {
          nickname,
          socketID: socket.id,
          playerType: "O",
        };
        socket.join(roomId);
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit('updatePlayers', room.players);
      } else {
        socket.emit(
          "errorOccurred",
          "The game is in Progress, Please try again later"
        );
      }
    } catch (e) {
      console.log(e);
    }
  });
});

// app listening
server.listen(port, "0.0.0.0", function () {
  console.log(`Example app listening at http://localhost:${port}`);
});
