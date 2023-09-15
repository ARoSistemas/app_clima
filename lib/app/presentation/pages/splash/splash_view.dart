import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/authentication_repository.dart';
import '../../../domain/repositories/connectivity_repository.dart';
import '../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  Future<void> _init() async {
    final connectivityRepository = Provider.of<ConnectivityRepository>(
      context,
      listen: false,
    );

    final authentication = Provider.of<AuthenticationRepository>(
      context,
      listen: false,
    );

    final hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      //

      final isSignedIn = await authentication.isSignedIn;

      if (isSignedIn) {
        final user = await authentication.getUserData();

        if (user != null) {
          _goTo(routeName: Routes.home);
        } else {
          _goTo(routeName: Routes.signin);
        }
      } else {
        _goTo(routeName: Routes.signin);
      }
    } else {
      _goTo(routeName: Routes.offline);
    }

    ///
  }

  void _goTo({required String routeName}) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
