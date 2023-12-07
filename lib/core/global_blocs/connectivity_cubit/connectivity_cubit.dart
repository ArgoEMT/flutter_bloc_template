import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityUnconnectedState());

  void setConnected() => emit(ConnectivityConnectedState());

  void setUnconnected() => emit(ConnectivityUnconnectedState());
}
