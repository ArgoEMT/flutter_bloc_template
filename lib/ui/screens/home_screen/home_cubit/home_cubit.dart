import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  final _homeService = HomeService();

  Future init() async {
    await _homeService.getHomeData().then(
          (data) => emit(HomeLoadedState(data)),
        );
  }

  Future loadMore() async {
    if (state is! HomeLoadedState) return;
    final currentData = [...((state as HomeLoadedState).data)];
    emit(HomeLoadedState(currentData, true));
    await _homeService.getMoreData().then((data) => emit(
          HomeLoadedState([...currentData, ' ', ...data]),
        ));
  }
}
