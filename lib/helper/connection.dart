import 'dart:io';

Future<bool> checkNetwork() async {
  bool connected = false;
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      connected = true;
    }
  } on SocketException catch (_) {
    print('not connected');
  }

  return connected;
}