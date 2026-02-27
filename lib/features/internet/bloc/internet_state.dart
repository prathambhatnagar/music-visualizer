import 'package:music_visualizer/core/constants/internet_constants.dart';

class InternetState {}

class InternetLoadingState extends InternetState {}

class InternetConnectedState extends InternetState {
  InternetConnectedState({required this.connectionType});
  final ConnectionType connectionType;
}

class InternetDisconnectedState extends InternetState {}
