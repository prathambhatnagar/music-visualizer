import 'package:flutter/material.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';
import 'package:music_visualizer/features/lyrics/bloc/lyrics_bloc_state.dart';

class LyrricsAppBar extends StatelessWidget {
  const LyrricsAppBar({
    super.key,
    required this.state,
    required this.trackEntity,
  });
  final LyricsState state;
  final TrackEntity trackEntity;

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.black,

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trackEntity.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            trackEntity.artist.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),

      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (trackEntity.album.coverMedium.isNotEmpty)
              Image.network(trackEntity.album.coverMedium, fit: BoxFit.cover),

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trackEntity.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      trackEntity.artist.name,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      trackEntity.album.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          size: 18,
                          color: Colors.white54,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatDuration(trackEntity.duration.inSeconds),
                          style: const TextStyle(color: Colors.white54),
                        ),

                        const SizedBox(width: 16),

                        const Icon(
                          Icons.trending_up,
                          size: 18,
                          color: Colors.white54,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "#${trackEntity.rank}",
                          style: const TextStyle(color: Colors.white54),
                        ),

                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
