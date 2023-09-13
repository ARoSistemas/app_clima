import 'package:shared_preferences/shared_preferences.dart';

class CacheDb {
  static final CacheDb _instancia = CacheDb._internal();

  factory CacheDb() => _instancia;

  CacheDb._internal();

  late SharedPreferences _dbCache;

  initPrefs() async => _dbCache = await SharedPreferences.getInstance();

  String get nomUser => _dbCache.getString('nomUser') ?? '';
  set nomUser(String value) => _dbCache.setString('nomUser', value);

  String get telUser => _dbCache.getString('telUser') ?? '';
  set telUser(String value) => _dbCache.setString('telUser', value);

//
}
