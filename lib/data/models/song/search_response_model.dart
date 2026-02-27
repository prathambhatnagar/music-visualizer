import 'package:json_annotation/json_annotation.dart';
import 'track_model.dart';

part 'search_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponseModel {
  final List<TrackModel> data;
  final int total;
  final String? next;

  SearchResponseModel({required this.data, required this.total, this.next});

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseModelToJson(this);
}
