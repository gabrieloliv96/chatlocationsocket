import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../enum/socket_events.dart';

class SocketClient {
  static final SocketClient _socketClient = SocketClient._internal();
  io.Socket socket = io.io('http://localhost:3000', {
    'autoConnect': false,
    'transports': ['websocket'],
  });

  SocketClient._internal();
  factory SocketClient() {
    return _socketClient;
  }

  connect() {
    socket.connect();
    socket.onConnectError((data) {
      log(data);
    });
  }

  sendMessage({required String message}) {
    socket.emit(SocketEvents.message.event, message);
  }

  void sendLocation(String name, String coordx, String coordy) {
    Map location = {'name': name, 'coordx': coordx, 'coordy': coordy};
    socket.emit(SocketEvents.sendLocation.event, location);
  }

  void sendBoardMove(
    int boardH,
    int boardV,
  ) {
    // Cria um mapa com a jogada do jogador
    Map<String, dynamic> playerMove = {
      '"h"': boardH,
      '"v"': boardV,
    };

    // Envia a jogada através do socket
    socket.emit(SocketEvents.boardMovement.event, playerMove.toString());
  }

  giveUp({
    required Color playerColor,
  }) {
    socket.emit(SocketEvents.giveUp.event, playerColor.toString());
  }

  turnEnd({required int playerTurn}) {
    Map turn = {'turn': playerTurn};
    socket.emit(
      SocketEvents.turnEnd.event,
      turn.toString(),
    );
  }

  firstPlayer({required int playerTurn}) {
    Map turn = {'turn': playerTurn};
    socket.emit(
      SocketEvents.firstPlayer.event,
      turn.toString(),
    );
  }
}
