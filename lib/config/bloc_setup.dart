import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/global_blocs/connectivity_cubit/connectivity_cubit.dart';

class BlocSetup {
  static List<BlocProvider> globalBlocs = [
    BlocProvider(create: (context) => ConnectivityCubit())
    //TODO: add global blocs
  ];
}
