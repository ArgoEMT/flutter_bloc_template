import 'package:get_it/get_it.dart';

import '../core/services/navigation_service.dart';

class ServicesSetup {
  /// Add a service to the GetIt locator if it is not already registered.
  static void _addService<T extends Object>(T service) {
    if (!GetIt.I.isRegistered<T>()) {
      GetIt.I.registerSingleton<T>(service);
    }
  }

  /// Initialize all services.
  static void init() {
    _addService<NavigationService>(NavigationService());

    //TODO: add services that need to be accessible globally
  }
}
