import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'config/app_router.dart';
import 'config/bloc_setup.dart';
import 'config/config_reader.dart';
import 'config/services_setup.dart';
import 'config/theme/app_theme.dart';
import 'core/services/navigation_service.dart';
import 'core/utils/log.dart';
import 'helpers/core_methods_platform_helper.dart';

Future run(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();

  ConfigReader.initialize(env);

  /// Initialize services
  ServicesSetup.init();

  // Error handling and logging
  FlutterError.onError = (FlutterErrorDetails details) {
    appLogger(
        message: details.exceptionAsString(),
        source: details.library ?? 'Caught in main');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    appLogger(message: error.toString(), source: 'Caught in main');
    return true;
  };

  runApp(MyApp(env: env));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.env});

  final Environment env;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (!kIsWeb) {
      SystemChrome.setSystemUIOverlayStyle(
        isIOS ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      );
    }

    return MultiBlocProvider(
      providers: BlocSetup.globalBlocs,
      child: MaterialApp(
        title: 'Flutter Bloc Template', //TODO: Change the name
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        navigatorKey: GetIt.I<NavigationService>().navigatorKey,
        theme: AppTheme.defaultTheme,
        onGenerateRoute: AppRouter.generateRoute,
        onGenerateInitialRoutes: (String initialRouteName) {
          return [
            AppRouter.generateRoute(
              const RouteSettings(
                name: RoutePaths.home, //TODO: change initial route
              ),
            ),
          ];
        },
      ),
    );
  }
}
