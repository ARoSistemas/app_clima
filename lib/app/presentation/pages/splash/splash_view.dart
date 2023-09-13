import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../routes/routes.dart';

class SplashView extends StatefulWidget {
  static String idPage = 'SplashView';

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
    final injector = Injector.of(context);

    final connectivityRepository = injector.connectivityRepository;
    final hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      //
      final authentication = injector.authenticationRepository;
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

  // appBar: AppBar(
      //   title: const Text('SplashView'),
      // ),
      // backgroundColor: Colors.blue,