import '../constants/api_routes.dart';
import '../enum/http_method_enum.dart';
import '../models/api/response_model.dart';
import '../models/home_model.dart';
import 'api_repository.dart';

class HomeApi extends ApiRepository {
  Future<ResponseModel<HomeDataModel>> getHomeData(int pageNumber) async {
    final response = await performRequest(
      url: ApiRoutes.getHomeDataUrl(pageNumber),
      method: HttpMethodEnum.get,
      toResponseModel: (json) => HomeDataModel.fromJson(json),
    );

    return response;
  }
}
