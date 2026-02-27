import 'package:music_visualizer/core/constants/internet_constants.dart';

class InternetEvent {}

class InternetDisconnected extends InternetEvent {}

class InternetConnected extends InternetEvent {
  InternetConnected({required this.connectionType});
  ConnectionType connectionType;
}
