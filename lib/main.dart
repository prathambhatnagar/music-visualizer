import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/core/dependency_injection/service_locator.dart';
import 'package:music_visualizer/domain/usecases/songs/load_songs_use_case.dart';
import 'package:music_visualizer/features/internet/bloc/internet_bloc.dart';
import 'package:music_visualizer/features/song_listing/bloc/song_listing_bloc.dart';
import 'package:music_visualizer/features/song_listing/screen/song_listing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await serviceInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SongListingBloc(
            loadSongsUseCase: serviceLoactor<LoadSongsUseCase>(),
          ),
        ),
        BlocProvider(create: (context) => serviceLoactor<InternetBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SongListingPage(),
      ),
    );
  }
}
