import 'package:dartz/dartz.dart';
import 'package:music_visualizer/core/failure/failure.dart';
import 'package:music_visualizer/data/services/lyrics/lyrics_remote_data_source.dart';
import 'package:music_visualizer/domain/entities/lyrics_entity/lyrics_entity.dart';
import 'package:music_visualizer/domain/repositories/lyrics/lyrics_repository.dart';

class LyricsRepositoryImpl implements LyricsRepository {
  final LyricsRemoteDataSource remoteDataSource;

  LyricsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<LyricsEntity>>> searchLyrics({
    required String trackName,
    required String artistName,
  }) async {
    try {
      final models = await remoteDataSource.searchLyrics(
        trackName: trackName,
        artistName: artistName,
      );

      final entities = models.map((e) => e.toEntity()).toList();

      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
