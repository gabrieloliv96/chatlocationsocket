import 'package:flutter/material.dart';

import '../enum/message.dart';
import '../enum/socket_events.dart';
import '../services/socket.dart';

class ChatClient extends StatefulWidget {
  const ChatClient({
    super.key,
  });

  @override
  State<ChatClient> createState() => _ChatClientState();
}

class _ChatClientState extends State<ChatClient> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textCoordXController = TextEditingController();
  final TextEditingController _textCoordYController = TextEditingController();
  final _client = SocketClient();
  final FocusNode _messageFocusNode = FocusNode();
  List<Message> mensagens = [];
  bool named = false;
  List<String> connetedClients = [];

  @override
  void initState() {
    _client.connect();
    _handleReceviedMessages();
    super.initState();
  }

  void _handleReceviedMessages() {
    _client.socket.on(
      SocketEvents.message.event,
      (message) {
        setState(
          () {
            mensagens.add(
              Message(mensagem: message, isSent: false, color: Colors.blue),
            );
          },
        );
      },
    );

    _client.socket.on(
      SocketEvents.newUser.event,
      (message) {
        setState(
          () {
            connetedClients.add(message);
            mensagens.add(
              Message(
                mensagem: message + " se conectou.",
                isSent: false,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          // width: 550,
          // height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 320,
                    child: TextField(
                      enabled: !named,
                      onSubmitted: (value) {
                        named = true;
                        setState(() {});
                        _sendMessage(_textNameController);
                      },
                      controller: _textNameController,
                      // focusNode: _messageFocusNode,
                      decoration: const InputDecoration(
                        filled: true, // Faz o fundo branco
                        fillColor: Colors.white, // Cor de fundo
                        border: OutlineInputBorder(
                          // Bordas arredondadas
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: 'Digite seu nome',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(88, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Ação a ser executada quando o botão for pressionado
                  //       named = true;

                  //       _sendMessage(_textNameController);
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 50, vertical: 15),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius:
                  //             BorderRadius.circular(30), // Bordas arredondadas
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'Enviar', // Texto do botão
                  //       style: TextStyle(
                  //         fontSize: 16, // Tamanho da fonte
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      expands: false,
                      onSubmitted: (value) {
                        _sendMessage(_textCoordXController);
                      },
                      controller: _textCoordXController,
                      // focusNode: _messageFocusNode,
                      decoration: const InputDecoration(
                        filled: true, // Faz o fundo branco
                        fillColor: Colors.white, // Cor de fundo
                        border: OutlineInputBorder(
                          // Bordas arredondadas
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: 'Coordenada x',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(88, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      expands: false,
                      onSubmitted: (value) {
                        _sendMessage(_textCoordYController);
                      },
                      controller: _textCoordYController,
                      // focusNode: _messageFocusNode,
                      decoration: const InputDecoration(
                        filled: true, // Faz o fundo branco
                        fillColor: Colors.white, // Cor de fundo
                        border: OutlineInputBorder(
                          // Bordas arredondadas
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: 'Coordenada y',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(88, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação a ser executada quando o botão for pressionado
                        _sendLocation(
                            _textNameController.text,
                            _textCoordXController.text,
                            _textCoordYController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Bordas arredondadas
                        ),
                      ),
                      child: const Text(
                        'Enviar', // Texto do botão
                        style: TextStyle(
                          fontSize: 16, // Tamanho da fonte
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 470,
          height: 350,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFE5DDD5),
                Color(0xFFB5B5B5),
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: mensagens.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Wrap(
                      alignment: mensagens[index].isSent
                          ? WrapAlignment.end
                          : WrapAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: mensagens[index].color,
                            // ? Colors.blueAccent
                            // : Colors.grey,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(
                            mensagens[index].mensagem,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(
                height: 1.0,
                color: Colors.blueAccent,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        _sendMessage(_textController);
                      },
                      controller: _textController,
                      focusNode: _messageFocusNode,
                      decoration: const InputDecoration(
                        hintText: 'Escreva uma mensagem!',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _sendMessage(_textController);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.send),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage(
    TextEditingController textController,
  ) {
    if (textController.text.isNotEmpty) {
      mensagens.add(
        Message(
            mensagem: textController.text,
            color: const Color.fromARGB(255, 107, 228, 244)),
      );
      _client.sendMessage(message: textController.text);
      textController.clear();
      _messageFocusNode.requestFocus();
      setState(() {});
    }
  }

  void _sendLocation(String name, String coordx, String coordy) {
    if (name.isEmpty || coordx.isEmpty || coordy.isEmpty) {
    } else {
      _client.sendLocation(name, coordx, coordy);
    }
  }
}
