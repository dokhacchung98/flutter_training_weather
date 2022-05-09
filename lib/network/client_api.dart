import 'package:http/http.dart';

class ClientApi {
  late Client client;

  static late final ClientApi _instance;

  ClientApi._internal() {
    client = Client();
    _instance = this;
  }

  factory ClientApi() {
    return ClientApi._internal();
  }
}
