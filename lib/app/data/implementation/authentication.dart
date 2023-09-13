import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/model/user.dart';
import '../../domain/repositories/authentication_repository.dart';

const _key = 'sessionId';

class AuthenticationImp implements AuthenticationRepository {
  final FlutterSecureStorage _secureStorage;

  AuthenticationImp(this._secureStorage);

  @override
  Future<User?> getUserData() {
    return Future.value(
      null,
    );
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId != null;
  }
}
