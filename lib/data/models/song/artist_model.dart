import 'package:json_annotation/json_annotation.dart';

part 'artist_model.g.dart';

@JsonSerializable()
class ArtistModel {
  final int id;
  final String name;

  @JsonKey(name: 'picture_medium')
  final String pictureMedium;

  ArtistModel({
    required this.id,
    required this.name,
    required this.pictureMedium,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);
}
