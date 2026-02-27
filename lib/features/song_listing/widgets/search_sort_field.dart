import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_bloc.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_event.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_state.dart';
import 'package:music_visualizer/features/song_listing/widgets/search_field.dart';

class SearchAndSortField extends StatelessWidget {
  const SearchAndSortField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SearchField(context: context)),
        const SizedBox(width: 8),
        PopupMenuButton<SortOrder>(
          icon: const Icon(Icons.sort, color: Colors.white),
          onSelected: (SortOrder order) {
            context.read<SongListingBloc>().add(SortSongs(order));
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: SortOrder.artistAZ,
              child: Text("Artist A-Z"),
            ),
            const PopupMenuItem(
              value: SortOrder.artistZA,
              child: Text("Artist Z-A"),
            ),
          ],
        ),
      ],
    );
  }
}
