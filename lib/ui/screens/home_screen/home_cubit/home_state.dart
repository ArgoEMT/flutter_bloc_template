part of 'home_cubit.dart';

sealed class HomeState {
  HomeState(this.isLoading);
  bool isLoading;
}

final class HomeInitialState extends HomeState {
  HomeInitialState() : super(true);
}

final class HomeLoadedState extends HomeState {
  HomeLoadedState(this.data, [super.isLoading = false]);
  final List<HomeDataModel> data;
}

final class HomeErrorState extends HomeState {
  HomeErrorState(this.message, [super.isLoading = false]);
  final String message;
}