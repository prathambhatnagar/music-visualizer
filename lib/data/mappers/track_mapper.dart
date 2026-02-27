import 'package:music_visualizer/data/mappers/album_mapper.dart';
import 'package:music_visualizer/domain/entities/track_enitity/artist_entity.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';
import '../models/song/track_model.dart';

extension TrackModelMapper on TrackModel {
  TrackEntity toEntity() {
    return TrackEntity(
      id: id,
      title: title,
      titleShort: title,
      duration: Duration(seconds: duration),
      isExplicit: false,
      rank: rank,
      artist: artist.toEntity(),
      album: album.toEntity(),
      previewUrl: preview,
    );
  }
}
