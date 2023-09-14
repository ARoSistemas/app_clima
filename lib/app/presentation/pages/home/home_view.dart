import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/home_ctrler.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../global/menu_bottom.dart';

class HomeView extends StatefulWidget {
  static String idPage = 'HomeView';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _nombre = '';
  String _miGps = '0.0,0.0';

  bool isGarantedGPS = false;

  final snack = Flushbar(
    icon: Icon(Icons.report, color: Colors.amber.shade600, size: 80),
    title: '¡Permiso del GPS denegado!',
    titleColor: Colors.black,
    message:
        'Para el óptimo funcionamiento de la app, debe permitir el uso del GPS',
    messageColor: Colors.black,
    messageSize: 20.0,
    isDismissible: true,
    backgroundColor: Colors.amber.shade200,
    leftBarIndicatorColor: Colors.amber.shade500,
    borderColor: Colors.amber.shade300,
    borderWidth: 2.0,
    duration: const Duration(seconds: 5),
    animationDuration: const Duration(milliseconds: 350),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    padding: const EdgeInsets.only(left: 35.0, right: 0, top: 10, bottom: 20),
    forwardAnimationCurve: Curves.easeInQuad,
  );

  void getDataWeather() async {
    final ctrler = Provider.of<HomeCtrler>(context, listen: false);

    final authentication =
        Provider.of<AuthenticationRepository>(context, listen: false);

    final clima = await authentication.getWeather(_miGps);

    ctrler.showLoading = false;
    ctrler.leyenda = 'Obteniendo GPS';

    ctrler.climaAct = '${clima.current.tempC}';
    ctrler.humedad = '${clima.current.humidity}';
    ctrler.tempMin = '${clima.forecast.forecastday[0].day.mintempC}';
    ctrler.tempMax = '${clima.forecast.forecastday[0].day.maxtempC}';
    ctrler.viento = '${clima.current.windKph}';
    ctrler.sunRise = clima.forecast.forecastday[0].astro.sunrise;
    ctrler.sunSet = clima.forecast.forecastday[0].astro.sunset;
    ctrler.ciudad = clima.location.name;
    ctrler.pais = ' ${clima.location.country}';
  }

  Future<void> getGPS() async {
    final ctrler = Provider.of<HomeCtrler>(context, listen: false);
    // evito que se refresque a cada rato.
    isGarantedGPS = true;

    if (!ctrler.isFirst) return;
    ctrler.isFirst = false;
    ctrler.delData();

    // obtengo el GPS Actual
    final gps = await Geolocator.getCurrentPosition();
    _miGps = '${gps.latitude},${gps.longitude}';

    setState(() {});

    ctrler.leyenda = 'Obteniendo datos del clima';

    // Pido los datos del clima del gps
    getDataWeather();

    return;
  }

  // Se obtienen los permisos del S.O.
  void requestPermission() async {
    final PermissionStatus status =
        await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }

    if (status == PermissionStatus.denied) {
      // Muestro snackbar
      if (!mounted) return;
      snack.show(context);
    } else if (status == PermissionStatus.granted) {
      // Si tengo los permisos previos, procedo con la carga
      getGPS();
    }
  }

  ///
  Future<void> checkPermission() async {
    // Obtengo el permiso de uso
    final status = await Permission.locationWhenInUse.isGranted;

    if (!status) {
      // Si no tengo el permiso, muestro la leyenda de solicitud
      // Los vuelvo a pedir.
      requestPermission();
    } else {
      // Si tengo los permisos previos, procedo con la carga
      getGPS();
    }

    //
  }

  void _getData() async {
    final authentication =
        Provider.of<AuthenticationRepository>(context, listen: false);

    final user = await authentication.getUserData();

    _nombre = user?.nombre ?? '';
    setState(() {});

    // Permiso del gps
    checkPermission();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getData());
  }

  @override
  Widget build(BuildContext context) {
    final ctrler = Provider.of<HomeCtrler>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Clima')),
      backgroundColor: Colors.grey.shade50,
      body: LiquidPullToRefresh(
        color: const Color(0xff6200ee),
        onRefresh: () {
          ctrler.isFirst = true;
          return getGPS();
        },
        showChildOpacityTransition: false,
        child: ListView(
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 15),
                  child: Text(
                    'Hola $_nombre!',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShortCard(
                  imagen: 'assets/png/weather.png',
                  tipo: 'Weather',
                  dato: '${ctrler.climaAct}° C',
                  isGarantedGPS: isGarantedGPS,
                ),
                ShortCard(
                  imagen: 'assets/png/degree.png',
                  tipo: 'Degree',
                  dato: '${ctrler.humedad}%',
                  isGarantedGPS: isGarantedGPS,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShortCard(
                  imagen: 'assets/png/grados.png',
                  tipo: '${ctrler.tempMin} Min',
                  dato: '${ctrler.tempMax} Max',
                  isGarantedGPS: isGarantedGPS,
                ),
                ShortCard(
                  imagen: 'assets/png/wind.png',
                  tipo: 'Wind',
                  dato: '${ctrler.viento} Km/hr',
                  isGarantedGPS: isGarantedGPS,
                ),
              ],
            ),
            const SizedBox(height: 10),
            LongCard(
              ciudad: ctrler.ciudad,
              pais: ctrler.pais,
              sunrise: ctrler.sunRise,
              sunset: ctrler.sunSet,
              isGarantedGPS: isGarantedGPS,
            ),
            Visibility(
              visible: ctrler.showLoading,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CircularProgressIndicator(),
                      ),
                      Text(ctrler.leyenda)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MenuBottom(currentIndex: 0),
    );
  }
}

class ShortCard extends StatelessWidget {
  final String imagen;
  final String tipo;
  final String dato;
  final bool isGarantedGPS;

  const ShortCard({
    Key? key,
    required this.imagen,
    required this.tipo,
    required this.dato,
    required this.isGarantedGPS,
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
          child: !isGarantedGPS
              ? null
              : FadeIn(
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
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 15),
                          JelloIn(child: Text(dato)),
                        ],
                      )
                    ],
                  ),
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
  final bool isGarantedGPS;

  const LongCard({
    super.key,
    required this.ciudad,
    required this.pais,
    required this.sunrise,
    required this.sunset,
    required this.isGarantedGPS,
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
          child: !isGarantedGPS
              ? null
              : FadeInLeft(
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
                              FadeIn(
                                child: Text(
                                  ciudad,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 15),
                              FadeIn(child: Text(pais)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(height: 15),
                                      FadeIn(child: Text(sunrise)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(height: 15),
                                      FadeIn(child: Text(sunset)),
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
      ),
    );
  }
}
