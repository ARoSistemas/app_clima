import 'package:flutter/material.dart';

import '../../../data/services/local/cache_db.dart';
import '../../global/menu_bottom.dart';

class HomeView extends StatefulWidget {
  static String idPage = 'HomeView';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final dbCache = CacheDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima')),
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 15),
                child: Text(
                  'Hola ${dbCache.nomUser}!',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShortCard(
                imagen: 'assets/png/weather.png',
                tipo: 'Weather',
                dato: '25° C',
              ),
              ShortCard(
                imagen: 'assets/png/degree.png',
                tipo: 'Degree',
                dato: '30%',
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShortCard(
                imagen: 'assets/png/grados.png',
                tipo: '17°C Min',
                dato: '30°C Max',
              ),
              ShortCard(
                imagen: 'assets/png/wind.png',
                tipo: 'Wind',
                dato: '20 Km/hr',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const LongCard(
            ciudad: 'Colonia Roma',
            pais: 'MX',
            sunrise: '06:00 AM',
            sunset: '07:00 PM',
          ),
        ],
      ),
      bottomNavigationBar: const MenuBottom(currentIndex: 0),
    );
  }
}

class ShortCard extends StatelessWidget {
  final String imagen;
  final String tipo;
  final String dato;

  const ShortCard({
    Key? key,
    required this.imagen,
    required this.tipo,
    required this.dato,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hw = MediaQuery.of(context).size;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: hw.height * 0.1,
          width: hw.width * 0.44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                imagen,
                width: hw.width * 0.145,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tipo,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    dato,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LongCard extends StatelessWidget {
  final String ciudad;
  final String pais;
  final String sunrise;
  final String sunset;

  const LongCard({
    super.key,
    required this.ciudad,
    required this.pais,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    final hw = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: hw.height * 0.19,
          width: hw.width * 0.95,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/png/map.png',
                    width: hw.width * 0.145,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ciudad,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        pais,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 21),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/png/sunrise.png',
                            width: hw.width * 0.15,
                            height: hw.height * 0.2,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Sunrise',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                sunrise,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/png/sunset.png',
                            width: hw.width * 0.15,
                            height: hw.height * 0.2,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Sunset',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                sunset,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
