import 'package:music_visualizer/domain/entities/track_enitity/artist_entity.dart';
import 'package:music_visualizer/data/models/song/artist_model.dart';

extension ArtistModelMapper on ArtistModel {
  ArtistEntity toEntity() {
    return ArtistEntity(
      id: id,
      name: name,
      coverMedium: pictureMedium,
      trackList: '',
    );
  }
}
