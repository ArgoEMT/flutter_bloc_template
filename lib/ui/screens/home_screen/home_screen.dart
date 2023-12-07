import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config_reader.dart';
import '../../../generated/l10n.dart';
import '../../components/app_body.dart';
import 'home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit()..init();
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, state) => AppBody(
        isLoading: state.isLoading,
        title: '${ConfigReader.appName} ${S.of(context).home_title}',
        body: state is HomeLoadedState
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      children: state.data
                          .map(
                            (e) => Text(
                              e,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24.0),
                    OutlinedButton(
                      onPressed: cubit.loadMore,
                      child: const Text('Load More'),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
