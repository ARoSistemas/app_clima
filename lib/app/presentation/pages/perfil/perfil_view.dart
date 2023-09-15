import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:camera_snap/camera_snap.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/user.dart';
import '../../../domain/repositories/authentication_repository.dart';
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
  bool isFetching = false;

  String _nombre = '';
  String _correo = '';
  String _tel = '';

  String? _selfie;

  void getData() async {
    final auth = Provider.of<AuthenticationRepository>(
      context,
      listen: false,
    );

    final user = await auth.getUserData();

    _correo = user?.correo ?? '';
    _tel = user?.tel ?? '';
    _nombre = user?.nombre ?? '';
    _selfie = user?.selfie;
    setState(() {});
  }

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
                      onPressed: () {
                        Navigator.pop(context);
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
    if (mounted) {
      if (_correo.trim().isEmpty || _tel.trim().isEmpty) return;

      isFetching = true;
      setState(() {});

      final authentication = Provider.of<AuthenticationRepository>(
        context,
        listen: false,
      );

      authentication.upData(
        User(
          _nombre,
          _tel,
          _correo,
          _selfie ?? '',
        ),
      );

      showAlert();

      isFetching = false;
      setState(() {});
    }
  }

  void takePhoto() async {
    final camara = CameraSnapScreen(
      cameraType: CameraType.front,
      appBar: AppBar(
        title: const Text('Tomar imagen'),
        backgroundColor: const Color(0xff6200ee),
      ),
    );

    //
    _selfie = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => camara),
    );

    if (_selfie == null) return;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  @override
  Widget build(BuildContext context) {
    final hw = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: AbsorbPointer(
          absorbing: isFetching,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => takePhoto(),
                    child: _selfie == null || _selfie!.trim().isEmpty
                        ? Icon(
                            Icons.account_circle,
                            size: hw.height * 0.15,
                            color: const Color(0xff6200ee),
                          )
                        : Container(
                            width: hw.width * 0.28,
                            height: hw.height * 0.15,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(_selfie!)),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              color: const Color(0xff6200ee),
                            ),
                          ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// Titulo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenido $_nombre!',
                    style: const TextStyle(fontSize: 22, color: Colors.black54),
                  ),
                ],
              ),

              SizedBox(height: hw.height * 0.05),

              // EL correo
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: ElCorreo(
                  setCorreo: (String value) => _correo = value,
                ),
              ),

              // EL telefono
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: ElTelefono(
                  setTelefono: (String value) {
                    _tel = value;
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
                            // Se borran datos y se cierra sesion

                            final authentication =
                                Provider.of<AuthenticationRepository>(context,
                                    listen: false);
                            authentication.signOut().then((value) {
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
      ),
      bottomNavigationBar: const MenuBottom(
        currentIndex: 1,
      ),
    );
  }

  ///
}
