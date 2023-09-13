import '../model/clima.dart';

abstract class GetClimaRepository {
  // Obtener el clima de la ciudad
  Future<Clima?> getClima({required String ciudad}) {
    throw UnimplementedError();
  }
}
