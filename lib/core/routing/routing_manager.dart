import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:test1/core/routing/routes.dart';
import 'package:test1/data/models/topic.dart';
import 'package:test1/screens/home/home.dart';
import 'package:test1/screens/newTopic/newTopic.dart';

class RoutingPageType<T> {
  final String routeName;
  Object? args;

  RoutingPageType.root() : routeName = Routes.root;
  RoutingPageType.home() : routeName = Routes.home;
  RoutingPageType.newTopic({required Function(TopicModel) addNewTopic})
      : routeName = Routes.newTopic,
        args = addNewTopic;
}

class RoutingManager {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get navigatorState => navigatorKey.currentState!;

  static BuildContext get rootContext => navigatorState.overlay!.context;

  static Route<dynamic> onRootGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialWithModalsPageRoute(
            settings: settings, builder: (_) => const Home());
    }
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('UnknownRoute')),
          body: const Text('UnknownRoute'),
        );
      },
    );
  }

  showModalStackDialog<T>(RoutingPageType routingPageType) {
    switch (routingPageType.routeName) {
      case Routes.newTopic:
        return showCupertinoModalBottomSheet(
          context: rootContext,
          expand: true,
          backgroundColor: Colors.transparent,
          builder: (context) => NewTopic(addNewTopic: routingPageType.args as Function(TopicModel newTopic),),
        );
      default:
        break;
    }
    return Container();
  }
}
