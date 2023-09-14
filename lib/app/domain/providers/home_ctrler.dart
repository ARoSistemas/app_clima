import 'package:flutter/material.dart';

class HomeCtrler with ChangeNotifier {
  bool _isFirst = true;
  bool get isFirst => _isFirst;
  set isFirst(bool value) {
    _isFirst = value;
    notifyListeners();
  }

  String _leyenda = 'Obteniendo GPS';
  String get leyenda => _leyenda;
  set leyenda(String value) {
    _leyenda = value;
    notifyListeners();
  }

  bool _showLoading = true;
  bool get showLoading => _showLoading;
  set showLoading(bool value) {
    _showLoading = value;
    notifyListeners();
  }

  String _climaAct = '';
  String get climaAct => _climaAct;
  set climaAct(String value) {
    _climaAct = value;
    notifyListeners();
  }

  String _humedad = '';
  String get humedad => _humedad;
  set humedad(String value) {
    _humedad = value;
    notifyListeners();
  }

  String _tempMin = '';
  String get tempMin => _tempMin;
  set tempMin(String value) {
    _tempMin = value;
    notifyListeners();
  }

  String _tempMax = '';
  String get tempMax => _tempMax;
  set tempMax(String value) {
    _tempMax = value;
    notifyListeners();
  }

  String _viento = '';
  String get viento => _viento;
  set viento(String value) {
    _viento = value;
    notifyListeners();
  }

  String _ciudad = '';
  String get ciudad => _ciudad;
  set ciudad(String value) {
    _ciudad = value;
    notifyListeners();
  }

  String _pais = '';
  String get pais => _pais;
  set pais(String value) {
    _pais = value;
    notifyListeners();
  }

  String _sunRise = '';
  String get sunRise => _sunRise;
  set sunRise(String value) {
    _sunRise = value;
    notifyListeners();
  }

  String _sunSet = '';
  String get sunSet => _sunSet;
  set sunSet(String value) {
    _sunSet = value;
    notifyListeners();
  }

  void delData() {
    _climaAct = '';
    _humedad = '';
    _tempMin = '';
    _tempMax = '';
    _viento = '';
    _sunRise = '';
    _sunSet = '';
    _ciudad = '';
    _pais = '';
    notifyListeners();
  }

  ///
}
