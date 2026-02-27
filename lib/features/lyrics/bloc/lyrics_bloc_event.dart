abstract class LyricsEvent {}

class FetchLyrics extends LyricsEvent {
  final String trackName;
  final String artistName;

  FetchLyrics({required this.trackName, required this.artistName});
}
