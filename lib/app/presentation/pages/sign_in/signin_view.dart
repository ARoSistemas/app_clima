import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/authentication_repository.dart';
import '../../../domain/repositories/huella_repository.dart';
import '../../global/styles/buttons.dart';
import '../../routes/routes.dart';
import 'nombre.dart';

class SignInView extends StatefulWidget {
  static String idPage = 'SignInView';

  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  ///

  final snackBar = const SnackBar(
    content: Text('Ingrese un nombre, antes de continuar...'),
  );

  String _nombre = '';
  bool _biometrico = false;

  void checkData() async {
    final authentication = Provider.of<AuthenticationRepository>(
      context,
      listen: false,
    );

    // Si estoy mostrando el teclado
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 750));
    }

    if (_nombre.trim().isEmpty) return;

    authentication.saveName(_nombre.trim());

    //
    if (!mounted) return;
    Navigator.popAndPushNamed(context, Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final hw = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Inicio')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Titulo
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenido!',
                    style: TextStyle(fontSize: 40, color: Colors.black54),
                  ),
                ],
              ),

              SizedBox(height: hw.height * 0.3),

              Padding(
                padding: const EdgeInsets.all(13.0),
                child: ElNombre(setNombre: (value) => _nombre = value),
              ),

              // Boton
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: ElevatedButton(
                          style: StylesButtons.myStyle,
                          onPressed: () => checkData(),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Text(
                              'INGRESAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: hw.height * 0.1),

              // Habilitar biometricos
              SwitchListTile(
                title: const Text(
                  'Habilitar biometricos',
                  textAlign: TextAlign.end,
                ),
                value: _biometrico,
                activeColor: Colors.green,
                onChanged: (bool value) async {
                  if (_nombre.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                  _biometrico = value;
                  setState(() {});

                  final authBiometric = Provider.of<HuellaRepository>(
                    context,
                    listen: false,
                  );

                  if (value) _biometrico = await authBiometric.hasHuella();
                  setState(() {});

                  if (_biometrico) checkData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
}
