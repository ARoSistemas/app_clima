import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OfflineView extends StatelessWidget {
  static String idPage = 'OfflineView';

  const OfflineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hw = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 250, //hw.height * 0.7,
                height: 250, // hw.width * 0.7,
                child: Lottie.asset('assets/animations/sin_datos.json'),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: hw.width * 0.8,
                child: const Text(
                    'Es necesario conexión a internet para el óptimo funcionamiento de esta app.',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: hw.width * 0.8,
                child: const Text(
                    'Active la conexión a internet, por medio de datos o wifi.',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
