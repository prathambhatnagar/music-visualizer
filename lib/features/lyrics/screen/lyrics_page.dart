import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/core/dependency_injection/service_locator.dart';
import 'package:music_visualizer/core/widgets/internet_error_widget.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';
import 'package:music_visualizer/domain/usecases/lyrics/get_lyrics_use_case.dart';
import 'package:music_visualizer/features/internet/bloc/internet_bloc.dart';
import 'package:music_visualizer/features/internet/bloc/internet_state.dart';
import 'package:music_visualizer/features/lyrics/bloc/lyrics_bloc.dart';
import 'package:music_visualizer/features/lyrics/bloc/lyrics_bloc_event.dart';
import 'package:music_visualizer/features/lyrics/bloc/lyrics_bloc_state.dart';
import 'package:music_visualizer/features/lyrics/widgets/lyrics_app_bar.dart';
import 'package:music_visualizer/features/lyrics/widgets/lyrics_content.dart';

class LyricsPage extends StatefulWidget {
  final TrackEntity trackEntity;

  const LyricsPage({super.key, required this.trackEntity});

  static MaterialPageRoute route(TrackEntity trackEntity) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) =>
            LyricsBloc(getLyricsUseCase: serviceLoactor<GetLyricsUseCase>()),
        child: LyricsPage(trackEntity: trackEntity),
      ),
    );
  }

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  @override
  void initState() {
    super.initState();
    _fetchLyrics();
  }

  void _fetchLyrics() {
    context.read<LyricsBloc>().add(
      FetchLyrics(
        trackName: widget.trackEntity.title,
        artistName: widget.trackEntity.artist.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, internetState) {
        if (internetState is InternetConnectedState) {
          _fetchLyrics();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            BlocBuilder<LyricsBloc, LyricsState>(
              builder: (context, lyricsState) {
                return LyrricsAppBar(
                  state: lyricsState,
                  trackEntity: widget.trackEntity,
                );
              },
            ),

            BlocBuilder<InternetBloc, InternetState>(
              builder: (context, internetState) {
                return BlocBuilder<LyricsBloc, LyricsState>(
                  builder: (context, lyricsState) {
                    final lyricsLoaded = lyricsState.lyrics.isNotEmpty;

                    if (!lyricsLoaded &&
                        internetState is InternetDisconnectedState) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: InternetErrorWidget(),
                      );
                    }

                    return LyricsContent(lyricsState: lyricsState);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
