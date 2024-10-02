import 'package:diary_mate/core/resources/helpers.dart';
import 'package:diary_mate/core/themes/pallet.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:diary_mate/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:diary_mate/features/diary/presentation/widgets/history_diary_entry_tile.dart';
import 'package:diary_mate/features/diary/presentation/widgets/today_diary_entry_tile.dart';
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

  void _deleteDiaryEntry(DiaryEntity diaryEntry) {
    context.read<DiaryBloc>().add(
          DiaryRemoveEntry(diaryEntry),
        );
  }

  List<String> greetings = [
    'No entries yet.',
    'Your day is just beginning.',
    'Quiet day so far.',
  ];

  List<DiaryEntity> getTodaysEntries(List<DiaryEntity> allEntries) {
    final today = DateTime.now();
    return allEntries.where((entry) {
      final entryDate = DateTime.parse(entry.date);
      return entryDate.year == today.year &&
          entryDate.month == today.month &&
          entryDate.day == today.day;
    }).toList();
  }

  List<DiaryEntity> getPastEntries(List<DiaryEntity> allEntries) {
    final today = DateTime.now();
    return allEntries.where((entry) {
      final entryDate = DateTime.parse(entry.date);
      return entryDate.year != today.year ||
          entryDate.month != today.month ||
          entryDate.day != today.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<DiaryBloc, DiaryState>(
        listener: (context, state) {
          // if (state is DiaryLoaded) {
          //   print(state.diaryEntries);
          // }
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
            return Scaffold(
              appBar: _buildAppBar(),
              body: _buildBody(context, state.diaryEntries),
              floatingActionButton: _buildFAB(),
            );
          }
          if (state is DiaryError) {
            return Scaffold(
              appBar: _buildAppBar(),
              body: _buildErrorBody(state.error),
              floatingActionButton: _buildFAB(),
            );
          }
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildErrorBody('Something went wrong'),
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

  _buildBody(BuildContext context, List<DiaryEntity>? diaryEntries) {
    diaryEntries ??= [];
    final todaysEntries = getTodaysEntries(diaryEntries);
    final pastEntries = getPastEntries(diaryEntries);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildTodayDiaryItems(todaysEntries),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildHistoryDiaryItems(pastEntries),
          ),
        ],
      ),
    );
  }

  _buildTodayDiaryItems(List<DiaryEntity> diaryEntries) {
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
        const SizedBox(height: 8),
        if (diaryEntries.isEmpty)
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(6),
            color: Pallete.borderColor,
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
        if (getTodaysEntries(diaryEntries).isNotEmpty)
          ListView.builder(
            shrinkWrap: true, // Prevent unnecessary scrolling
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling
            itemCount: diaryEntries.length,
            itemBuilder: (context, index) {
              final diaryEntry = diaryEntries[index];
              return TodayDiaryEntryTile(
                diaryEntry: diaryEntry,
                onTap: () {
                  _changeScreen(
                    '/diary_entry_details',
                    arguments: {'diaryEntry': diaryEntry},
                  );
                },
                onDelete: () {
                  _deleteDiaryEntry(diaryEntry);
                },
              );
            },
          ),
      ],
    );
  }

  _buildHistoryDiaryItems(List<DiaryEntity> diaryEntries) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (diaryEntries.isNotEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'History',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true, // Prevent unnecessary scrolling
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling
                itemCount: diaryEntries.length,
                itemBuilder: (context, index) {
                  final diaryEntry = diaryEntries[index];
                  return HistoryDiaryEntryTile(
                    diaryEntry: diaryEntry,
                    onTap: () {
                      _changeScreen(
                        '/diary_entry_details',
                        arguments: {'diaryEntry': diaryEntry},
                      );
                    },
                    onDelete: () {
                      _deleteDiaryEntry(diaryEntry);
                    },
                  );
                },
              ),
            ],
          ),
      ],
    );
  }
}
