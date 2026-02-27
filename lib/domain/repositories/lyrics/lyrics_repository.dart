import 'package:dartz/dartz.dart';
import 'package:music_visualizer/core/failure/failure.dart';
import 'package:music_visualizer/domain/entities/lyrics_entity/lyrics_entity.dart';

abstract class LyricsRepository {
  Future<Either<Failure, List<LyricsEntity>>> searchLyrics({
    required String trackName,
    required String artistName,
  });
}
