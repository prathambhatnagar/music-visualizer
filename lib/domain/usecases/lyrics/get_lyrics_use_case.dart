import 'package:dartz/dartz.dart';
import 'package:music_visualizer/core/failure/failure.dart';
import 'package:music_visualizer/domain/entities/lyrics_entity/lyrics_entity.dart';
import 'package:music_visualizer/domain/repositories/lyrics/lyrics_repository.dart';

class GetLyricsUseCase {
  final LyricsRepository repository;

  GetLyricsUseCase(this.repository);

  Future<Either<Failure, List<LyricsEntity>>> call({
    required String trackName,
    required String artistName,
  }) {
    return repository.searchLyrics(
      trackName: trackName,
      artistName: artistName,
    );
  }
}
