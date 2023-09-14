import 'package:http/http.dart';

import '../../../domain/model/clima.dart';

class GetClima {
  final Client _client;
  final String baseUrl = 'http://api.weatherapi.com';

  GetClima(this._client);

  Future<Clima> requestWeather(String gps) async {
    final res = await _client.get(
      Uri.parse(
          '$baseUrl/v1/forecast.json?key=8325fabf413e4269a9185334220912&q=$gps'),
    );

    if (res.statusCode == 200) {
      return Clima.fromJson(res.body);
    } else {
      return Clima.empty();
    }

    ///
  }

  ///
}
