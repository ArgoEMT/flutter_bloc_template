import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/home_model.dart';

import '../../../../core/services/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  final _homeService = HomeService();

  final List<HomeDataModel> data = [];

  var _pageNumber = 1;

  Future init() async {
    final response = await _homeService.getHomeData();

    if (response != null) {
      data.add(response);
      emit(HomeLoadedState(data));
    } else {
      emit(HomeErrorState('Error while fetching data'));
    }
  }

  Future loadMore() async {
    if (state is! HomeLoadedState) return;
    emit(HomeLoadedState(data, true));
    _pageNumber++;
    final response = await _homeService.getHomeData(_pageNumber);


    if (response != null) {
      data.add(response);
      emit(HomeLoadedState(data));
    } else {
      emit(HomeErrorState('Error while fetching data'));
    }
  }
}
