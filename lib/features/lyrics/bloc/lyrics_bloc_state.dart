import 'package:music_visualizer/domain/entities/lyrics_entity/lyrics_entity.dart';

class LyricsState {
  final bool isLoading;
  final List<LyricsEntity> lyrics;
  final String? error;

  const LyricsState({
    this.isLoading = false,
    this.lyrics = const [],
    this.error,
  });

  LyricsState copyWith({
    bool? isLoading,
    List<LyricsEntity>? lyrics,
    String? error,
  }) {
    return LyricsState(
      isLoading: isLoading ?? this.isLoading,
      lyrics: lyrics ?? this.lyrics,
      error: error,
    );
  }
}
