import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/core/widgets/internet_error_widget.dart';
import 'package:music_visualizer/core/widgets/loader.dart';
import 'package:music_visualizer/core/widgets/no_results_found.dart';
import 'package:music_visualizer/core/widgets/something_went_wrong.dart';
import 'package:music_visualizer/features/internet/bloc/internet_bloc.dart';
import 'package:music_visualizer/features/internet/bloc/internet_state.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_bloc.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_event.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_state.dart';
import 'package:music_visualizer/features/song_listing/widgets/search_sort_field.dart';
import 'package:music_visualizer/features/song_listing/widgets/track_tile.dart';

class SongListingPage extends StatefulWidget {
  const SongListingPage({super.key});

  @override
  State<SongListingPage> createState() => _SongListingPageState();
}

class _SongListingPageState extends State<SongListingPage> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    context.read<SongListingBloc>().add(FetchSongs(query: "a"));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<SongListingBloc>().add(
        FetchSongs(
          query: context.read<SongListingBloc>().state.songs.isEmpty
              ? ''
              : context.read<SongListingBloc>().state.songs.first.title,
          isLoadMore: true,
        ),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, internetState) {
        if (internetState is InternetConnectedState) {
          context.read<SongListingBloc>().add(FetchSongs(query: "a"));
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 100,
              pinned: true,
              backgroundColor: Colors.deepPurple,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                title: SearchAndSortField(),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                    ),
                  ),
                ),
              ),
            ),

            BlocBuilder<InternetBloc, InternetState>(
              builder: (context, internetState) {
                if (internetState is InternetDisconnectedState) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: InternetErrorWidget(),
                  );
                }

                return BlocBuilder<SongListingBloc, SongListingState>(
                  buildWhen: (previous, current) =>
                      previous.songs != current.songs ||
                      previous.isLoading != current.isLoading ||
                      previous.error != current.error,
                  builder: (context, state) {
                    if (state.isLoading && state.songs.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Loader(),
                      );
                    }
                    if (state.error != null && state.songs.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: SomethingWentWrong(),
                      );
                    }

                    if (!state.isLoading && state.songs.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: NoResultsFound(),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= state.songs.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Loader(),
                            );
                          }

                          final track = state.songs[index];
                          return TrackTitle(trackEntity: track);
                        },
                        childCount: state.hasReachedMax
                            ? state.songs.length
                            : state.songs.length + 1,
                      ),
                    );
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
