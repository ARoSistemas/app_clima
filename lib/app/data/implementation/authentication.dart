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
  final CacheDb dbCache;

  AuthenticationImp(
    this._secureDb,
    this.dbCache,
  );

  @override
  Future<User?> getUserData() async {
    final nombre = dbCache.nomUser;
    final tel = dbCache.telUser;
    final correo = await _secureDb.read(key: _key);

    return Future.value(
      User(nombre, tel, correo ?? ''),
    );
  }

  @override
  Future<bool> get isSignedIn async {
    return dbCache.nomUser.isNotEmpty;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
    String userName,
  ) async {
    // if (userName != 'andy') {
    //   return Either.left(SignInFailure.notFound);
    // }
    // Se guarda el nombre de usuario
    dbCache.nomUser = userName;

    return Either.right(User(userName, '', ''));
  }

  @override
  Future<void> signOut() async {
    await _secureDb.deleteAll();
    dbCache.nomUser = '';
    dbCache.telUser = '';
  }

  @override
  void upData(User user) async {
    dbCache.nomUser = user.nombre;
    dbCache.telUser = user.tel;
    await _secureDb.write(key: _key, value: user.correo);
  }

  @override
  Future<Clima> getWeather(String gps) async {
    final cliente = GetClima(Client());
    return cliente.requestWeather(gps);
  }
}
