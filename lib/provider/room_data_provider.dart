import 'package:flutter/material.dart';
import 'package:mp_tictactoe/models/player.dart';

class RoomDataProvider extends ChangeNotifier{
  Map <String, dynamic> _roomData = {};

  Player _player1 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'X',
  );

  Player _player2 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'o',
  );

  Map <String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data){
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map <String, dynamic> player1Data){
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2data){
    _player2 = Player.fromMap(player2data);
    notifyListeners();
  }
}