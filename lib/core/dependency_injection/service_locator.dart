import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_visualizer/core/network/network_info.dart';
import 'package:music_visualizer/data/repositories/lyrics/lyrics_repository_impl.dart';
import 'package:music_visualizer/data/repositories/song/song_repository.dart';
import 'package:music_visualizer/data/services/lyrics/lyrics_remote_data_source.dart';
import 'package:music_visualizer/data/services/song/song_remote_data_source.dart';
import 'package:music_visualizer/domain/repositories/lyrics/lyrics_repository.dart';
import 'package:music_visualizer/domain/repositories/songlisting/song_repository.dart';
import 'package:music_visualizer/domain/usecases/lyrics/get_lyrics_use_case.dart';
import 'package:music_visualizer/domain/usecases/songs/load_songs_use_case.dart';
import 'package:music_visualizer/features/internet/bloc/internet_bloc.dart';

GetIt serviceLoactor = GetIt.instance;

Future<void> serviceInit() async {
  serviceLoactor.registerSingleton<Dio>(Dio());

  serviceLoactor.registerSingleton<SongRemoteDataSource>(
    SongRemoteDataSourceImpl(serviceLoactor<Dio>()),
  );

  serviceLoactor.registerSingleton<LoadSongsUseCase>(LoadSongsUseCase());

  serviceLoactor.registerSingleton<LyricsRemoteDataSource>(
    LyricsRemoteDataSourceImpl(serviceLoactor<Dio>()),
  );

  serviceLoactor.registerSingleton<LyricsRepository>(
    LyricsRepositoryImpl(serviceLoactor<LyricsRemoteDataSource>()),
  );

  serviceLoactor.registerSingleton<GetLyricsUseCase>(
    GetLyricsUseCase(serviceLoactor<LyricsRepository>()),
  );

  serviceLoactor.registerSingleton<Connectivity>(Connectivity());

  serviceLoactor.registerSingleton<InternetBloc>(
    InternetBloc(connectivity: serviceLoactor<Connectivity>()),
  );

  serviceLoactor.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(serviceLoactor<Connectivity>()),
  );

  serviceLoactor.registerSingleton<SongRepository>(
    SongRepositoryImpl(
      serviceLoactor<SongRemoteDataSource>(),
      serviceLoactor<NetworkInfo>(),
    ),
  );
}
