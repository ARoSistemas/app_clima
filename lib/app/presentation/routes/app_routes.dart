import 'package:flutter/material.dart';

import '../pages/home/home_view.dart';
import '../pages/offline/offline_view.dart';
import '../pages/perfil/perfil_view.dart';
import '../pages/sign_in/signin_view.dart';
import '../pages/splash/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.offline: (context) => const OfflineView(),
    Routes.signin: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.perfil: (context) => const PerfilView(),
  };
}
