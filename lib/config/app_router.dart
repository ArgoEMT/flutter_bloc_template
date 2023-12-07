import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ui/screens/home_screen/home_screen.dart';

class AppRouter {
  static MaterialPageRoute<T> routeBuilder<T extends Object?>({
    required Widget target,
    required RouteSettings? settings,
    bool maintainState = true,
  }) {
    return CustomPageRoute<T>(
      builder: (context) {
        return target;
      },
      settings: settings,
      maintainState: maintainState,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var name = settings.name;

    switch (name) {
      case RoutePaths.home:
        return routeBuilder(
          target: const HomeScreen(),
          settings: settings,
        );

      /// Handeling 404
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Pas de route ${settings.name!}'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      onPressed: () => context.go(RoutePaths.home),
                      child: const Text("Aller à l'accueil"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}

class CustomPageRoute<T extends Object?> extends MaterialPageRoute<T> {
  CustomPageRoute({
    required Widget Function(BuildContext) builder,
    RouteSettings? settings,
    required bool maintainState,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 175);
}

class RoutePaths {
  static const home = '/';
  //TODO: add routes
}

extension NavigationExtension on BuildContext {
  Future<T?> go<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool replace = false,
  }) {
    if (kIsWeb || replace) {
      return Navigator.pushReplacementNamed<T, T>(
        this,
        routeName,
        arguments: arguments,
      );
    }
    return Navigator.pushNamed<T?>(this, routeName, arguments: arguments);
  }

  Future<T?> goToUnamed<T extends Object?>(
    Widget child, {
    bool replace = false,
  }) {
    if (kIsWeb || replace) {
      return Navigator.pushReplacement(
        this,
        AppRouter.routeBuilder(target: child, settings: null),
      );
    }
    return Navigator.push(
      this,
      AppRouter.routeBuilder(target: child, settings: null),
    );
  }

  void pop<T extends Object?>([T? result]) {
    if (canPop) {
      Navigator.pop(this, result);
    } else {
      quitTo(RoutePaths.home);
    }
  }

  void popUntil<T extends Object?>(String routeName) {
    if (canPop) {
      Navigator.popUntil(this, ModalRoute.withName(routeName));
    } else {
      quitTo(RoutePaths.home);
    }
  }

  Future<T?> quitTo<T extends Object?>(String routeName,
      {Object? arguments}) async {
    return await Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  bool get canPop => Navigator.canPop(this);
}
