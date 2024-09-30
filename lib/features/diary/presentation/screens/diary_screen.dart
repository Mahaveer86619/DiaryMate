import 'package:diary_mate/core/resources/helpers.dart';
import 'package:diary_mate/core/themes/pallet.dart';
import 'package:diary_mate/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
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

    context.read<DiaryBloc>().add(const DiaryGetAllEntries());
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> greetings = [
    'No entries yet.',
    'Your day is just beginning.',
    'Quiet day so far.',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<DiaryBloc, DiaryState>(
        listener: (context, state) {
          if (state is DiaryError) {
            _showMessage(state.error);
          } else if (state is DiaryLoaded) {
            _showMessage('Diary entry loaded!');
          }
        },
        builder: (context, state) {
          if (state is DiaryLoading) {
            return Scaffold(
              appBar: _buildAppBar(),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
              floatingActionButton: _buildFAB(),
            );
          }
          if (state is DiaryLoaded) {
            print(state.diaryEntries);
            return Scaffold(
              appBar: _buildAppBar(),
              body: _buildBody(context),
              floatingActionButton: _buildFAB(),
            );
          }
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(context),
            floatingActionButton: _buildFAB(),
          );
        },
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        'DiaryMate',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        _changeScreen('/add_diary_entry');
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: const Icon(Icons.add),
    );
  }

  _buildErrorBody(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ],
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildTodayDiaryItems(),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: _buildHistoryDiaryItems(),
          // ),
        ],
      ),
    );
  }

  _buildTodayDiaryItems() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Today',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        Text(
          formatDate(DateTime.now().toIso8601String()),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Pallete.greyColor,
              ),
        ),
        const SizedBox(height: 16),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(6),
          color: Pallete.greyColor,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 64.0,
                  ),
                  child: Text(
                    getRandomString(greetings),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildHistoryDiaryItems() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'History',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
