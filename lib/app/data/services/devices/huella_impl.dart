import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../../../domain/repositories/huella_repository.dart';
import '../../../presentation/pages/sign_in/aut_error.dart';

class HuellaImpl implements HuellaRepository {
  final LocalAuthentication _auth;

  HuellaImpl(this._auth);

  ///

  @override
  Future<bool> hasHuella() async {
    final canAuthBiometrics = await _auth.canCheckBiometrics;
    final canAuth = canAuthBiometrics || await _auth.isDeviceSupported();

    if (!canAuthBiometrics && !canAuth) {
      return false;
    }
    // Solo si es posible usar biometricos

    final List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      try {
        final auth = LocalAuthentication();

        final isAuth = await auth.authenticate(
          localizedReason: 'Escanee su huella, para continuar',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );

        return isAuth;

        //
      } on PlatformException catch (e) {
        if (e.code == AuthError.notEnrolled) {
        } else if (e.code == AuthError.lockedOut ||
            e.code == AuthError.permanentlyLockedOut) {
        } else {}
      }
    }

    return false;
  }

  ///
}
