import 'package:flutter_bloc_template/core/api/api_repository.dart';
import 'package:flutter_bloc_template/core/enum/http_method_enum.dart';

class HomeApi extends ApiRepository {

  Future<String> getHomeData() async {
    final response = await performRequest(
      url: 'https://jsonplaceholder.typicode.com/todos/1',
      method: HttpMethodEnum.get,
    );
    return response.body;
  }
}