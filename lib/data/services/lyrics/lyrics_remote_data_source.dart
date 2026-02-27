import 'package:dio/dio.dart';
import 'package:music_visualizer/data/models/lyrics/lyrics_model.dart';

abstract class LyricsRemoteDataSource {
  Future<List<LyricsModel>> searchLyrics({
    required String trackName,
    required String artistName,
  });
}

class LyricsRemoteDataSourceImpl implements LyricsRemoteDataSource {
  final Dio dio;

  LyricsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<LyricsModel>> searchLyrics({
    required String trackName,
    required String artistName,
  }) async {
    final response = await dio.get(
      'https://lrclib.net/api/search',
      queryParameters: {'track_name': trackName, 'artist_name': artistName},
    );

    final List data = response.data;

    return data.map((e) => LyricsModel.fromJson(e)).toList();
  }
}
