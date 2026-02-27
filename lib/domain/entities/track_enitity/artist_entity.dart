import 'package:music_visualizer/data/models/song/artist_model.dart';

class ArtistEntity {
  final int id;
  final String name;
  final String coverMedium;
  final String trackList;

  ArtistEntity({
    required this.id,
    required this.name,
    required this.coverMedium,
    required this.trackList,
  });
}

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
