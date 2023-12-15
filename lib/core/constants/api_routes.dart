import 'package:flutter_bloc_template/config/config_reader.dart';
import 'package:get_it/get_it.dart';

class ApiRoutes {
  static String get _baseUrl => GetIt.I<AppConfig>().apiBaseUrl;

  // Routes todo
  static final _todoUrl = '$_baseUrl/todos';
  static String getHomeDataUrl(int page) => '$_todoUrl/$page';

  // Other routes
  //TODO: Add your api routes
}
