import 'package:flutter/material.dart';

import '../../../data/services/local/cache_db.dart';
import '../../global/aro_lib.dart';

class ElTelefono extends StatefulWidget {
  final ValueChanged<String> setTelefono;

  const ElTelefono({
    Key? key,
    required this.setTelefono,
  }) : super(key: key);

  @override
  State<ElTelefono> createState() => _ElTelefonoState();
}

class _ElTelefonoState extends State<ElTelefono> {
  final dbCache = CacheDb();
  final _focusTel = FocusNode();
  final _telCtrler = TextEditingController();
  final _regex = RegExp(Andy.patternTel, caseSensitive: true);

  bool _isTelOk = false;
  bool _showLeyenda = false;

  // Validaciones del input
  void onFieldSubmitted() {
    if (_telCtrler.text.trim() == '') {
      widget.setTelefono('');
    } else {
      _isTelOk = (_regex.hasMatch(_telCtrler.text)) ? true : false;
      _showLeyenda = !_isTelOk;
      widget.setTelefono(_isTelOk ? _telCtrler.text.trim() : '');
    }

    setState(() {});
  }

  void onChanged() {
    if (_telCtrler.text.trim() == '') {
      _showLeyenda = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _telCtrler.text = dbCache.telUser;
    _focusTel.addListener(() {
      if (!_focusTel.hasFocus) onFieldSubmitted();
    });
  }

  @override
  void dispose() {
    _telCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _telCtrler,
          focusNode: _focusTel,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: Colors.black.withOpacity(.05),
            hintText: 'Teléfono',
            // labelText: 'Label',
            alignLabelWithHint: true,
            label: const Center(
              child: Text(
                'Teléfono',
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
            'Número de teléfono inválido',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
