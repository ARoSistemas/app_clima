import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../global/aro_lib.dart';

class ElCorreo extends StatefulWidget {
  final ValueChanged<String> setCorreo;

  const ElCorreo({
    Key? key,
    required this.setCorreo,
  }) : super(key: key);

  @override
  State<ElCorreo> createState() => _ElCorreoState();
}

class _ElCorreoState extends State<ElCorreo> {
  final secureDb = const FlutterSecureStorage();
  final _focusCorreo = FocusNode();
  final _correoCtrler = TextEditingController();
  final _regex = RegExp(Andy.patternCorreo, caseSensitive: true);

  bool _isCorreoOk = false;
  bool _showLeyenda = false;

  void getOldData() async {
    final oldCorreo = await secureDb.read(key: 'correo');
    _correoCtrler.text = oldCorreo ?? '';
  }

  // Validaciones del input
  void onFieldSubmitted() {
    if (_correoCtrler.text.trim() == '') {
      widget.setCorreo('');
    } else {
      _isCorreoOk = (_regex.hasMatch(_correoCtrler.text));
      _showLeyenda = !_isCorreoOk;
      widget.setCorreo(_isCorreoOk ? _correoCtrler.text.trim() : '');
    }

    setState(() {});
  }

  void onChanged() {
    if (_correoCtrler.text.trim() == '') {
      _showLeyenda = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getOldData();
    _focusCorreo.addListener(() {
      if (!_focusCorreo.hasFocus) onFieldSubmitted();
    });
  }

  @override
  void dispose() {
    _correoCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _correoCtrler,
          focusNode: _focusCorreo,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            fillColor: Colors.black.withOpacity(.05),
            hintText: 'Correo',
            // labelText: 'Label',
            alignLabelWithHint: true,
            label: const Center(
              child: Text(
                'Correo',
              ),
            ),
            counter: const SizedBox.shrink(),
          ),
          onFieldSubmitted: (valor) => onFieldSubmitted(),
          onChanged: (valor) => onChanged(),
          maxLength: 80,
        ),

        // Mostrar advertencia
        Visibility(
          visible: _showLeyenda,
          child: const Text(
            'Correo electrónico inválido',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
