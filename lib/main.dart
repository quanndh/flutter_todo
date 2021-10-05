import 'package:flutter/material.dart';

import 'core/routing/routes.dart';
import 'core/routing/routing_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF1372F0),
      ),
      onGenerateRoute: RoutingManager.onRootGenerateRoute,
      initialRoute: Routes.home,
      navigatorKey: RoutingManager.navigatorKey,
      debugShowCheckedModeBanner: false,

    );
  }
}