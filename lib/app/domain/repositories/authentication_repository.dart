import '../enums.dart';
import '../model/clima.dart';
import '../model/user.dart';
import 'either.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;

  Future<User?> getUserData();

  Future<void> signOut();

  void upData(User user) {}

  void saveName(String nombre) {}

  Future<Clima> getWeather(String gps);

  Future<Either<SignInFailure, User>> signIn(
    String userName,
  );

  ///
}
