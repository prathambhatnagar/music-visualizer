// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  duration: (json['duration'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
  preview: json['preview'] as String,
  artist: ArtistModel.fromJson(json['artist'] as Map<String, dynamic>),
  album: AlbumModel.fromJson(json['album'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'rank': instance.rank,
      'preview': instance.preview,
      'artist': instance.artist,
      'album': instance.album,
    };
