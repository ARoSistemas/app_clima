import 'package:http/http.dart' as http;

import '../../../domain/model/clima.dart';
import '../../../domain/repositories/get_clima_repository.dart';

class HttpGetClima extends GetClimaRepository {
  //
  @override
  Future<Clima> getClima({required String ciudad}) async {
    Clima ret = Clima(
      location: Location(
          name: '',
          region: '',
          country: '',
          lat: 0,
          lon: 0,
          tzId: '',
          localtimeEpoch: 0,
          localtime: ''),
      current: Current(
        lastUpdatedEpoch: 0,
        lastUpdated: '',
        tempC: 0,
        tempF: 0,
        isDay: 0,
        condition: Condition(
          text: '',
          icon: '',
          code: 0,
        ),
        windMph: 0,
        windKph: 0,
        windDegree: 0,
        windDir: '',
        pressureMb: 0,
        pressureIn: 0,
        precipMm: 0,
        precipIn: 0,
        humidity: 0,
        cloud: 0,
        feelslikeC: 0,
        feelslikeF: 0,
        visKm: 0,
        visMiles: 0,
        uv: 0,
        gustMph: 0,
        gustKph: 0,
      ),
    );

    final urlClima = Uri.http(
      'api.weatherapi.com',
      '/v1/current.json',
      {
        'key': '8325fabf413e4269a9185334220912',
        'q': ciudad,
      },
    );
    try {
      final peticion = await http.get(urlClima);

      if (peticion.statusCode == 200) {
        ret = Clima.fromJson(peticion.body);
        // si fue exitoso el proceso.
      }
    } catch (e) {
      //
    }

    return ret;
  }
}
