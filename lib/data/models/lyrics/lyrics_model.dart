import 'package:json_annotation/json_annotation.dart';
import 'package:music_visualizer/domain/entities/lyrics_entity/lyrics_entity.dart';

part 'lyrics_model.g.dart';

@JsonSerializable()
class LyricsModel {
  final int id;
  final String trackName;
  final String artistName;

  @JsonKey(fromJson: _albumFromJson)
  final String albumName;

  final double duration;
  final bool instrumental;
  final String plainLyrics;
  final String syncedLyrics;

  const LyricsModel({
    required this.id,
    required this.trackName,
    required this.artistName,
    required this.albumName,
    required this.duration,
    required this.instrumental,
    required this.plainLyrics,
    required this.syncedLyrics,
  });

  factory LyricsModel.fromJson(Map<String, dynamic> json) =>
      _$LyricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LyricsModelToJson(this);

  LyricsEntity toEntity() {
    return LyricsEntity(
      id: id,
      trackName: trackName,
      artistName: artistName,
      albumName: albumName,
      duration: duration,
      instrumental: instrumental,
      plainLyrics: plainLyrics,
      syncedLyrics: syncedLyrics,
    );
  }

  static String _albumFromJson(dynamic value) {
    if (value == null || value == "null") return '';
    return value as String;
  }
}
