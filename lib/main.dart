import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'app/aro_app.dart';
import 'app/data/implementation/authentication.dart';
import 'app/data/implementation/connectivity.dart';
import 'app/data/services/local/cache_db.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/providers/home_ctrler.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbCache = CacheDb();
  await dbCache.initPrefs();

  // Se crea el cache seguro
  const FlutterSecureStorage();

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
            const FlutterSecureStorage(),
            dbCache,
          ),
        ),
        ChangeNotifierProvider<HomeCtrler>(
          create: (_) => HomeCtrler(),
        ),
      ],
      child: const ARoApp(),
    ),
  );
}
