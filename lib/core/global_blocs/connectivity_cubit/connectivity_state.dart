part of 'connectivity_cubit.dart';

sealed class ConnectivityState {}

final class ConnectivityUnconnectedState extends ConnectivityState {}

final class ConnectivityConnectedState extends ConnectivityState {}

