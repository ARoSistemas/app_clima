import 'package:flutter/material.dart';

import 'presentation/global/aro_colors.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class ARoApp extends StatelessWidget {
  static String idPage = 'ARoApp';

  const ARoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: createMaterialColor(
            const Color(0xff6200ee),
          ),
        ),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      routes: appRoutes,
    );
  }
}
