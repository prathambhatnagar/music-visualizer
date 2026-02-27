import 'package:dartz/dartz.dart';
import 'package:music_visualizer/core/failure/failure.dart';
import 'package:music_visualizer/data/services/song/song_remote_data_source.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';

abstract class SongRepository {
  Future<Either<Failure, List<TrackEntity>>> loadSongs({
    required SongPaginationParams songPaginationParams,
  });
}
