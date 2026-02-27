import 'package:music_visualizer/domain/entities/track_enitity/album_entity.dart';
import 'package:music_visualizer/data/models/song/album_model.dart';

extension AlbumModelMapper on AlbumModel {
  AlbumEntity toEntity() {
    return AlbumEntity(
      id: id.toString(),
      title: title,
      coverMedium: coverMedium,
      trackList: '',
    );
  }
}
