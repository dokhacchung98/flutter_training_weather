import 'package:flutter_weather/network/client_api.dart';
import 'package:flutter_weather/network/weather_api.dart';

class WeatherBLoC {
  getAA() async* {
    try {
      final ClientApi clientApi = ClientApi();
      final WeatherApi weatherApi = WeatherApi(clientApi.client);
    } catch (err) {
      // yield async
    }
  }
}
