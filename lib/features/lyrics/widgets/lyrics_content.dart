import 'package:flutter/material.dart';
import 'package:music_visualizer/core/widgets/no_results_found.dart';
import 'package:music_visualizer/features/lyrics/bloc/lyrics_bloc_state.dart';

class LyricsContent extends StatelessWidget {
  const LyricsContent({super.key, required this.lyricsState});
  final LyricsState lyricsState;
  @override
  Widget build(BuildContext context) {
    if (lyricsState.isLoading) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (lyricsState.error != null) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text(lyricsState.error!)),
      );
    }

    if (lyricsState.lyrics.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: NoResultsFound(
          message: "No Lyrics Found",
          icon: Icons.music_note,
        ),
      );
    }

    final lyrics = lyricsState.lyrics.first.plainLyrics;

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Text(lyrics, style: const TextStyle(fontSize: 18, height: 1.6)),
      ),
    );
  }
}
