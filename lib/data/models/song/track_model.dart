import 'package:json_annotation/json_annotation.dart';
import 'artist_model.dart';
import 'album_model.dart';

part 'track_model.g.dart';

@JsonSerializable()
class TrackModel {
  final int id;
  final String title;
  final int duration;
  final int rank;
  final String preview;

  final ArtistModel artist;
  final AlbumModel album;

  TrackModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.rank,
    required this.preview,
    required this.artist,
    required this.album,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) =>
      _$TrackModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrackModelToJson(this);
}
