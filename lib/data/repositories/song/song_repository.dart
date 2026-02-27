import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:music_visualizer/core/failure/failure.dart';
import 'package:music_visualizer/core/network/network_info.dart';
import 'package:music_visualizer/data/mappers/track_mapper.dart';
import 'package:music_visualizer/data/services/song/song_remote_data_source.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';
import 'package:music_visualizer/domain/repositories/songlisting/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SongRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<TrackEntity>>> loadSongs({
    required SongPaginationParams songPaginationParams,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NoInternetFailure());
    }

    try {
      final response = await remoteDataSource.loadSongs(
        query: songPaginationParams.query,
        index: songPaginationParams.index,
        limit: songPaginationParams.limit,
      );

      final tracks = response.map((model) => model.toEntity()).toList();

      return Right(tracks);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Dio error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
