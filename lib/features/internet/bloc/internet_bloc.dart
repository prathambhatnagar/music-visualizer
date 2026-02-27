import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/core/constants/internet_constants.dart';
import 'package:music_visualizer/features/internet/bloc/interner_event.dart';
import 'package:music_visualizer/features/internet/bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity connectivity;
  late StreamSubscription<List<ConnectivityResult>> streamSubscription;

  InternetBloc({required this.connectivity})
    : super(InternetDisconnectedState()) {
    _checkInitialConnection();

    streamSubscription = connectivity.onConnectivityChanged.listen((results) {
      _handleConnectivityResults(results);
    });

    on<InternetDisconnected>((event, emit) {
      emit(InternetDisconnectedState());
    });

    on<InternetConnected>((event, emit) {
      emit(InternetConnectedState(connectionType: event.connectionType));
    });
  }

  void _handleConnectivityResults(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      add(InternetConnected(connectionType: ConnectionType.wifi));
    } else if (results.contains(ConnectivityResult.mobile)) {
      add(InternetConnected(connectionType: ConnectionType.mobile));
    } else {
      add(InternetDisconnected());
    }
  }

  Future<void> _checkInitialConnection() async {
    final results = await connectivity.checkConnectivity();
    _handleConnectivityResults(results);
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
