import 'package:diary_mate/common/widgets/text_field.dart';
import 'package:diary_mate/core/themes/pallet.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:diary_mate/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryEntryDetailsScreen extends StatefulWidget {
  const DiaryEntryDetailsScreen({super.key});

  @override
  State<DiaryEntryDetailsScreen> createState() =>
      _DiaryEntryDetailsScreenState();
}

class _DiaryEntryDetailsScreenState extends State<DiaryEntryDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  var titleText = 'Details';
  var isEditing = false;

  late DiaryEntity diaryEntry;

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

  _onSaveDiaryEntry() {
    if (_formKey.currentState!.validate()) {
      context.read<DiaryBloc>().add(
            DiarySaveEntry(
              DiaryEntity(
                id: diaryEntry.id,
                entryTitle: _titleController.text.trim() == ''
                    ? diaryEntry.entryTitle
                    : _titleController.text.trim(),
                entryContent: _contentController.text.trim() == ''
                    ? diaryEntry.entryContent
                    : _contentController.text.trim(),
                date: diaryEntry.date,
              ),
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    diaryEntry = arguments['diaryEntry'] as DiaryEntity;

    return SafeArea(
      child: BlocConsumer<DiaryBloc, DiaryState>(
        listener: (context, state) {
          if (state is DiaryError) {
            _showMessage(state.error);
          } else if (state is DiaryLoaded) {
            _showMessage('Diary entry edited!');
            Navigator.pop(context);
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
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(context, diaryEntry),
            floatingActionButton: _buildFAB(),
          );
        },
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      automaticallyImplyLeading: true,
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            _changeScreen('/movie_recommends', arguments: {
              'diaryEntryContent': _contentController.text.trim() == ''
                  ? diaryEntry.entryContent
                  : _contentController.text.trim(),
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Pallete.borderColor,
                width: 1,
              ),
              gradient: const LinearGradient(
                colors: [
                  Pallete.gradient1,
                  Pallete.gradient2,
                  Pallete.gradient3,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.subtitles,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(width: 12),
                Text(
                  'Movie',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        if (isEditing) {
          _onSaveDiaryEntry();
        } else {
          setState(() {
            isEditing = true;
          });
        }
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: isEditing ? const Icon(Icons.save) : const Icon(Icons.edit),
    );
  }

  _buildBody(BuildContext context, DiaryEntity diaryEntry) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 22,
          ),
          // Form
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildForm(diaryEntry),
          ),
        ],
      ),
    );
  }

  _buildForm(DiaryEntity diaryEntry) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // title
          MyFormTextField(
            hintText: 'Title',
            controller: _titleController,
            keyboardType: TextInputType.text,
            label: 'Entry title',
            keyboardAction: TextInputAction.next,
            initialText: diaryEntry.entryTitle,
            disableInput: !isEditing,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Title is required';
              }
              return null;
            },
          ),

          const SizedBox(
            height: 12,
          ),

          // content
          MyBigTextField(
            hintText: 'Entry content',
            controller: _contentController,
            initialValue: diaryEntry.entryContent,
            disableInput: !isEditing,
            lines: 20,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Content is required';
              }
              return null;
            },
          ),

          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
