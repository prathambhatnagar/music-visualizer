import 'package:music_visualizer/features/song_listing/bloc/song_listing_state.dart';

abstract class SongListingEvent {}

class FetchSongs extends SongListingEvent {
  final String query;
  final bool isLoadMore;

  FetchSongs({required this.query, this.isLoadMore = false});
}

class SortSongs extends SongListingEvent {
  final SortOrder sortOrder;
  SortSongs(this.sortOrder);
}
