import 'package:flutter/material.dart';

class ElNombre extends StatefulWidget {
  final ValueChanged<String> setNombre;

  const ElNombre({
    Key? key,
    required this.setNombre,
  }) : super(key: key);

  @override
  State<ElNombre> createState() => _ElNombreState();
}

class _ElNombreState extends State<ElNombre> {
  final _focusNombre = FocusNode();
  final _nombreCtrler = TextEditingController();

  void onChanged() {
    widget.setNombre(_nombreCtrler.text.trim());
    setState(() {});
  }

  void isEmpty() {
    widget.setNombre('');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _focusNombre.addListener(() {
      if (!_focusNombre.hasFocus) {
        onChanged();
      }
    });
  }

  @override
  void dispose() {
    _nombreCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _nombreCtrler,
          focusNode: _focusNombre,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            fillColor: Colors.black.withOpacity(.05),
            hintText: 'Nombre',
            labelText: 'Ingresa tu nombre',
            counter: const SizedBox.shrink(),
          ),
          onFieldSubmitted: (valor) {},
          onChanged: (valor) => onChanged(),
          maxLength: 80,
        ),
      ],
    );
  }
}
