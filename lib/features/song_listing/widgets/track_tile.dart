import 'package:flutter/material.dart';
import 'package:music_visualizer/domain/entities/track_enitity/track_enitiy.dart';
import 'package:music_visualizer/features/lyrics/screen/lyrics_page.dart';

class TrackTitle extends StatelessWidget {
  const TrackTitle({super.key, required this.trackEntity});
  final TrackEntity trackEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => Navigator.push(context, LyricsPage.route(trackEntity)),
        title: Text(
          trackEntity.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          trackEntity.artist.name,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.deepPurple, Colors.deepPurpleAccent],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "ID: ${trackEntity.id}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
