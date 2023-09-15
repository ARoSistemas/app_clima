import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import '../../domain/enums.dart';
import '../../domain/model/clima.dart';
import '../../domain/model/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/repositories/either.dart';
import '../services/local/cache_db.dart';
import '../services/remote/get_clima.dart';

const _key = 'correo';

class AuthenticationImp implements AuthenticationRepository {
  final FlutterSecureStorage _secureDb;
  final CacheDb _dbCache;

  AuthenticationImp(
    this._secureDb,
    this._dbCache,
  );

  @override
  Future<User?> getUserData() async {
    final correo = await _secureDb.read(key: _key);

    return Future.value(
      User(_dbCache.nomUser, _dbCache.telUser, correo ?? '', _dbCache.selfie),
    );
  }

  @override
  Future<bool> get isSignedIn async {
    return _dbCache.nomUser.isNotEmpty;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
    String userName,
  ) async {
    // if (userName != 'andy') {
    //   return Either.left(SignInFailure.notFound);
    // }
    // Se guarda el nombre de usuario
    _dbCache.nomUser = userName;

    return Either.right(User(userName, '', '', ''));
  }

  @override
  Future<void> signOut() async {
    await _secureDb.deleteAll();
    _dbCache.nomUser = '';
    _dbCache.telUser = '';
  }

  @override
  void upData(User user) async {
    _dbCache.nomUser = user.nombre;
    _dbCache.telUser = user.tel;
    await _secureDb.write(key: _key, value: user.correo);
    _dbCache.selfie = user.selfie;
  }

  @override
  void saveName(String nombre) {
    _dbCache.nomUser = nombre;
  }

  @override
  Future<Clima> getWeather(String gps) async {
    final cliente = GetClima(Client());
    return cliente.requestWeather(gps);
  }

  ///
}
