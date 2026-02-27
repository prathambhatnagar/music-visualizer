import 'package:music_visualizer/domain/entities/track_enitity/album_entity.dart';
import 'package:music_visualizer/domain/entities/track_enitity/artist_entity.dart';

class TrackEntity {
  final int id;
  final String title;
  final String titleShort;
  final Duration duration;
  final bool isExplicit;
  final String previewUrl;
  final int rank;
  final ArtistEntity artist;
  final AlbumEntity album;

  TrackEntity({
    required this.id,
    required this.title,
    required this.titleShort,
    required this.duration,
    required this.isExplicit,
    required this.previewUrl,
    required this.rank,
    required this.artist,
    required this.album,
  });
}
