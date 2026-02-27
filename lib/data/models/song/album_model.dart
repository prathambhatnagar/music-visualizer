import 'package:json_annotation/json_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel {
  final int id;
  final String title;

  @JsonKey(name: 'cover_medium')
  final String coverMedium;

  AlbumModel({
    required this.id,
    required this.title,
    required this.coverMedium,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}
