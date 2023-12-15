import '../../ui/ui_helpers/ui_snackbar_helper.dart';
import '../api/home_api.dart';
import '../models/home_model.dart';

class HomeService {
  final _homeApi = HomeApi();

  Future<HomeDataModel?> getHomeData([int page = 1]) async {
    //? This could be used like this :
    final response = await _homeApi.getHomeData(page);

    if (response.success) {
      return response.result;
    } else {
      showSnackbar(titre: response.message);
      return null;
    }
  }
}
