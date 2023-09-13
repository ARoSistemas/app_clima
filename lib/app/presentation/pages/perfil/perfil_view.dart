import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';

import '../../../data/services/local/cache_db.dart';
import '../../global/menu_bottom.dart';
import '../../global/styles/buttons.dart';
import '../../routes/routes.dart';
import 'correo.dart';
import 'telefono.dart';

class PerfilView extends StatefulWidget {
  static String idPage = 'PerfilView';

  const PerfilView({Key? key}) : super(key: key);

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final dbCache = CacheDb();
  final secureDb = const FlutterSecureStorage();

  String _correo = '';
  String tel = '';

  void showAlert() async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ZoomIn(
          duration: const Duration(milliseconds: 350),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    width: 250,
                    height: 250,
                    color: Colors.white,
                    child: Lottie.asset('assets/animations/done.json')),
                const SizedBox(height: 10),
                const Text(
                  'Datos actualizados correctamente',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: StylesButtons.myStyle,
                      onPressed: () => {
                            Navigator.pop(context),
                          },
                      child: const Text('Aceptar')),
                ],
              ),
              const SizedBox(height: 25)
            ],
          ),
        );
      },
    );
  }

  void upData() async {
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 750));
    }

    if (_correo.trim().isEmpty || tel.trim().isEmpty) return;

    dbCache.telUser = tel;
    secureDb.write(key: 'email', value: _correo);

    showAlert();
  }

  @override
  Widget build(BuildContext context) {
    final hw = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: hw.height * 0.15,
                  color: const Color(0xff6200ee),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// Titulo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido ${dbCache.nomUser}',
                  style: const TextStyle(fontSize: 22, color: Colors.black54),
                ),
              ],
            ),

            SizedBox(height: hw.height * 0.05),

            // EL correo
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: ElCorreo(
                setCorreo: (String value) {
                  _correo = value;
                },
              ),
            ),

            // EL telefono
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: ElTelefono(
                setTelefono: (String value) {
                  tel = value;
                },
              ),
            ),
            SizedBox(height: hw.height * 0.05),

            // Boton Act datos
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: ElevatedButton(
                        style: StylesButtons.myStyle,
                        onPressed: () => upData(),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            'ACTUALIZAR DATOS',
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
            SizedBox(height: hw.height * 0.05),

            // Boton Cerrar sesion
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: ElevatedButton(
                        style: StylesButtons.myStyle,
                        onPressed: () async {
                          // borrar el SecureStorage
                          await secureDb.delete(key: 'email').then((value) {
                            dbCache.nomUser = '';
                            dbCache.telUser = '';
                            Navigator.popAndPushNamed(context, Routes.signin);
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            'CERRAR SESION',
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
          ],
        ),
      ),
      bottomNavigationBar: const MenuBottom(
        currentIndex: 1,
      ),
    );
  }
}
