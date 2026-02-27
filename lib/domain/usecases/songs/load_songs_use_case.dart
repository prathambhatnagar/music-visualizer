import 'package:dartz/dartz.dart';
import 'package:music_visualizer/core/dependency_injection/service_locator.dart';
import 'package:music_visualizer/core/failure/failure.dart';
import 'package:music_visualizer/core/use_case/use_case.dart';
import 'package:music_visualizer/data/services/song/song_remote_data_source.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';
import 'package:music_visualizer/domain/repositories/songlisting/song_repository.dart';

class LoadSongsUseCase
    extends UseCase<List<TrackEntity>, SongPaginationParams> {
  @override
  Future<Either<Failure, List<TrackEntity>>> call(SongPaginationParams params) {
    return serviceLoactor<SongRepository>().loadSongs(
      songPaginationParams: params,
    );
  }
}
