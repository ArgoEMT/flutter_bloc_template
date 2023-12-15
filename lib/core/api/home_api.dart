import 'api_repository.dart';
import '../enum/http_method_enum.dart';
import '../models/api/response_model.dart';
import '../models/home_model.dart';

class HomeApi extends ApiRepository {
  Future<ResponseModel<HomeDataModel>> getHomeData(int pageNumber) async {
    final response = await performRequest(
      url: 'https://jsonplaceholder.typicode.com/todos/$pageNumber',
      method: HttpMethodEnum.get,
    );

    final responseModel =
        ResponseModel<HomeDataModel>(success: response.statusCode == 200);

    try {
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final homeData = HomeDataModel.fromJson(response.body);
        responseModel.result = homeData;
      } else {
        responseModel.message = 'Error while fetching data';
      }
    } catch (e) {
      responseModel.message = e.toString();
    }

    return responseModel;
  }
}
