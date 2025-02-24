import 'package:flutter/material.dart';

class Message {
  String mensagem;
  bool isSent;
  Color color;

  Message(
      {required this.mensagem,
      this.isSent = true,
      this.color = Colors.transparent});
}
