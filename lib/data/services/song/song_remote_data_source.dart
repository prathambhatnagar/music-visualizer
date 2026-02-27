import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:music_visualizer/data/models/song/track_model.dart';
import 'package:dio/dio.dart';

abstract class SongRemoteDataSource {
  Future<List<TrackModel>> loadSongs({
    required int index,
    required int limit,
    required String query,
  });
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final Dio dio;

  SongRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TrackModel>> loadSongs({
    required int index,
    required int limit,
    required String query,
  }) async {
    log('index : $index , limit: $limit');
    final response = await dio.get(
      'https://api.deezer.com/search/track',
      queryParameters: {'q': query, 'index': index, 'limit': limit},
    );

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((e) => TrackModel.fromJson(e)).toList();
    } else {
      throw Exception('Server error');
    }
  }
}

class SongPaginationParams extends Equatable {
  final int index;
  final int limit;
  final String query;
  const SongPaginationParams({
    required this.index,
    required this.limit,
    required this.query,
  });

  @override
  List<Object?> get props => [index, limit, query];
}
