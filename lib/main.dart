import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import 'app/aro_app.dart';
import 'app/data/implementation/authentication.dart';
import 'app/data/implementation/connectivity.dart';
import 'app/data/services/devices/huella_impl.dart';
import 'app/data/services/devices/myselfie_impl.dart';
import 'app/data/services/local/cache_db.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/providers/home_ctrler.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/huella_repository.dart';
import 'app/domain/repositories/myselfie_repository.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbCache = CacheDb();
  await dbCache.initPrefs();

  // Se crea el cache seguro
  const secureDb = FlutterSecureStorage();

  runApp(
    MultiProvider(
      providers: [
        Provider<ConnectivityRepository>(
          create: (context) => ConnectivityImp(
            Connectivity(),
            InternetChecker(),
          ),
        ),
        Provider<AuthenticationRepository>(
          create: (context) => AuthenticationImp(
            secureDb,
            dbCache,
          ),
        ),
        Provider<HuellaRepository>(
          create: (context) => HuellaImpl(
            LocalAuthentication(),
          ),
        ),
        Provider<MySelfieRepository>(
          create: (context) => MySelfieImpl(),
        ),
        ChangeNotifierProvider<HomeCtrler>(
          create: (_) => HomeCtrler(),
        ),
      ],
      child: const ARoApp(),
    ),
  );
}
