import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/domain/usecases/lyrics/get_lyrics_use_case.dart';
import 'package:music_visualizer/features/lyrics/bloc/lyrics_bloc_event.dart';
import 'package:music_visualizer/features/lyrics/bloc/lyrics_bloc_state.dart';

class LyricsBloc extends Bloc<LyricsEvent, LyricsState> {
  final GetLyricsUseCase getLyricsUseCase;

  LyricsBloc({required this.getLyricsUseCase}) : super(const LyricsState()) {
    on<FetchLyrics>(_onFetchLyrics);
  }

  Future<void> _onFetchLyrics(
    FetchLyrics event,
    Emitter<LyricsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await getLyricsUseCase(
      trackName: event.trackName,
      artistName: event.artistName,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
      },
      (lyrics) {
        emit(state.copyWith(isLoading: false, lyrics: lyrics));
      },
    );
  }
}
