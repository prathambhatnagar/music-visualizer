import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/core/failure/failure.dart';
import 'package:music_visualizer/data/services/song/song_remote_data_source.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';
import 'package:music_visualizer/domain/usecases/songs/load_songs_use_case.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_event.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_state.dart';

class SongListingBloc extends Bloc<SongListingEvent, SongListingState> {
  final LoadSongsUseCase loadSongsUseCase;

  static const int _limit = 10;
  int _currentIndex = 0;
  String _currentQuery = '';

  SongListingBloc({required this.loadSongsUseCase})
    : super(const SongListingState()) {
    on<FetchSongs>(_onFetchSongs);
    on<SortSongs>((event, emit) {
      List<TrackEntity> sortedSongs = List.from(state.songs);

      if (event.sortOrder == SortOrder.artistAZ) {
        sortedSongs.sort((a, b) => a.artist.name.compareTo(b.artist.name));
      } else if (event.sortOrder == SortOrder.artistZA) {
        sortedSongs.sort((a, b) => b.artist.name.compareTo(a.artist.name));
      }

      emit(state.copyWith(songs: sortedSongs, sortOrder: event.sortOrder));
    });
  }

  Future<void> _onFetchSongs(
    FetchSongs event,
    Emitter<SongListingState> emit,
  ) async {
    final isNewQuery = !event.isLoadMore;

    if (!isNewQuery &&
        (state.hasReachedMax || state.isLoadingMore || state.isLoading)) {
      return;
    }

    if (isNewQuery) {
      _currentIndex = 0;
      _currentQuery = event.query;

      emit(
        state.copyWith(
          isLoading: true,
          songs: [],
          hasReachedMax: false,
          error: null,
        ),
      );
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    final result = await loadSongsUseCase(
      SongPaginationParams(
        index: _currentIndex,
        limit: _limit,
        query: _currentQuery,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isLoadingMore: false,
            error: failure is NoInternetFailure
                ? "No Internet Connection"
                : failure is ServerFailure
                ? failure.message
                : "Something went wrong",
          ),
        );
      },
      (newSongs) {
        final allSongs = event.isLoadMore
            ? [...state.songs, ...newSongs]
            : newSongs;

        _currentIndex += _limit;

        emit(
          state.copyWith(
            songs: allSongs,
            isLoading: false,
            isLoadingMore: false,
            hasReachedMax: newSongs.length < _limit,
            error: null,
          ),
        );
      },
    );
  }
}
