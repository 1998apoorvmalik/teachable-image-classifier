import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider {
  final String socketUrl;

  IO.Socket socket;
  bool _isConnected;

  SocketProvider({this.socketUrl = 'http://127.0.0.1:5000'})
      : _isConnected = false,
        socket = IO.io(socketUrl, <String, dynamic>{
          'transports': ['websocket'],
        }) {
    print('[INFO] Attempting to connect to the server.');

    socket.onConnect((_) {
      _isConnected = true;
      print('[INFO] Successfully connected to the socket server.');
    });
    socket.onDisconnect((_) {
      _isConnected = false;
      print('[INFO] Disconnected from the socket server.');
    });

    // socket.on('message', (data) => print(data));
    // socket.on('event', (data) => print(data));
    // socket.on('fromServer', (data) => print(data));
  }

  get isSocketConnected => _isConnected;
}
