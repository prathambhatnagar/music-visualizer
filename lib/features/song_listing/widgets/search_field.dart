import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_bloc.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_event.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search songs...",
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withAlpha(50),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (value) {
          if (value.trim().isEmpty) return;

          context.read<SongListingBloc>().add(FetchSongs(query: value));
        },
      ),
    );
  }
}
