import 'package:equatable/equatable.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';

enum SortOrder { none, artistAZ, artistZA }

class SongListingState extends Equatable {
  final List<TrackEntity> songs;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? error;
  final SortOrder sortOrder;

  const SongListingState({
    this.songs = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.error,
    this.sortOrder = SortOrder.none,
  });

  SongListingState copyWith({
    List<TrackEntity>? songs,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasReachedMax,
    String? error,
    SortOrder? sortOrder,
  }) {
    return SongListingState(
      songs: songs ?? this.songs,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  List<Object?> get props => [
    songs,
    isLoading,
    isLoadingMore,
    hasReachedMax,
    error,
    sortOrder,
  ];
}
