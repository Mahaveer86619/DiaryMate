import 'package:diary_mate/core/resources/helpers.dart';
import 'package:diary_mate/core/themes/pallet.dart';
import 'package:diary_mate/features/movie_recomendation/domain/entities/movie_recomendation_entity.dart';
import 'package:diary_mate/features/movie_recomendation/presentation/bloc/movie_recomendation_bloc.dart';
import 'package:diary_mate/features/movie_recomendation/presentation/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieRecomendationScreen extends StatefulWidget {
  const MovieRecomendationScreen({super.key});

  @override
  State<MovieRecomendationScreen> createState() =>
      _MovieRecomendationScreenState();
}

class _MovieRecomendationScreenState extends State<MovieRecomendationScreen> {
  bool contentLoaded = false;
  String diaryEntryContent = "";

  void _changeScreen(
    String routeName, {
    Map<String, dynamic>? arguments,
    bool isReplacement = false,
  }) {
    if (isReplacement) {
      Navigator.pushReplacementNamed(
        context,
        routeName,
        arguments: arguments,
      );
    } else {
      Navigator.pushNamed(
        context,
        routeName,
        arguments: arguments,
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    diaryEntryContent = arguments['diaryEntryContent'] as String;

    if (diaryEntryContent.isNotEmpty) {
      context.read<MovieRecomendationBloc>().add(GetMovieRecomendations(
            prompt: getMovieRecomendationPrompt(diaryEntryContent),
          ));
    }
    return SafeArea(
      child: BlocConsumer<MovieRecomendationBloc, MovieRecomendationState>(
        listener: (context, state) {
          if (state is MovieRecomendationError) {
            _showMessage(state.error);
          }
        },
        builder: (context, state) {
          if (state is MovieRecomendationLoading) {
            return Scaffold(
              appBar: _buildAppBar(),
              body: _buildLoadingBody(),
            );
          }
          if (state is MovieRecomendationLoaded) {
            return Scaffold(
              appBar: _buildAppBar(),
              body: _buildBody(
                context,
                state.movieRecomendations,
              ),
            );
          }
          if (state is MovieRecomendationError) {
            return Scaffold(
              appBar: _buildAppBar(),
              body: _buildErrorBody(state.error),
            );
          }
          return Scaffold(
            appBar: _buildAppBar(),
            body: const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        'Recommendations',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (diaryEntryContent.isNotEmpty) {
              context.read<MovieRecomendationBloc>().add(GetMovieRecomendations(
                    prompt: getMovieRecomendationPrompt(diaryEntryContent),
                  ));
            }
          },
          icon: const Icon(
            Icons.sync,
            color: Pallete.greyColor,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  _buildLoadingBody() {
    return Center(
      child: Text(
        'Loading...',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  _buildErrorBody(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              if (diaryEntryContent.isNotEmpty) {
                context
                    .read<MovieRecomendationBloc>()
                    .add(GetMovieRecomendations(
                      prompt: getMovieRecomendationPrompt(diaryEntryContent),
                    ));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                border: Border.all(
                  color: Pallete.borderColor,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Text(
                'Try again',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBody(
    BuildContext context,
    List<MovieRecomendationEntity> movieRecomendations,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildRecomendationMethod(movieRecomendations),
          ),
        ],
      ),
    );
  }

  _buildRecomendationMethod(
    List<MovieRecomendationEntity> movieRecomendations,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true, // Prevent unnecessary scrolling
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          itemCount: movieRecomendations.length,
          itemBuilder: (context, index) {
            final diaryEntry = movieRecomendations[index];
            return MovieTile(
              movieRecomendationEntity: diaryEntry,
            );
          },
        ),
      ],
    );
  }
}
