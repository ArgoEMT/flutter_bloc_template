import '../../ui/ui_helpers/ui_snackbar_helper.dart';
import '../api/home_api.dart';

class HomeService {
  final _homeApi = HomeApi();

  Future<List<String>> getHomeData() async {
    //? This could be used like this :
    // _homeApi.getHomeData();

    await Future.delayed(const Duration(seconds: 2));
    return ['Hello', 'World', '!'];
  }

  Future<List<String>> getMoreData() async {
    await Future.delayed(const Duration(seconds: 1));
    showSnackbar(titre: 'More data successfully loaded');
    return ['world', '.', 'execute', '(', 'me', ')', ';'];
  }
}
