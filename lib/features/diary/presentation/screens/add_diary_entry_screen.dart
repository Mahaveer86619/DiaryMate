import 'package:diary_mate/common/widgets/text_field.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:diary_mate/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/v1.dart';

class AddDiaryEntryScreen extends StatefulWidget {
  const AddDiaryEntryScreen({super.key});

  @override
  State<AddDiaryEntryScreen> createState() => _AddDiaryEntryScreenState();
}

class _AddDiaryEntryScreenState extends State<AddDiaryEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  var uuid = const UuidV1();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

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
                id: uuid.generate(),
                entryTitle: _titleController.text.trim(),
                entryContent: _contentController.text.trim(),
                date: DateTime.now().toIso8601String(),
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
    return SafeArea(
      child: BlocConsumer<DiaryBloc, DiaryState>(
        listener: (context, state) {
          if (state is DiaryError) {
            _showMessage(state.error);
          } else if (state is DiaryLoaded) {
            _showMessage('Diary entry added!');
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
      automaticallyImplyLeading: true,
      title: Text(
        'Add diary entry',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        _onSaveDiaryEntry();
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: const Icon(Icons.save),
    );
  }

  _buildBody(BuildContext context) {
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
            child: _buildForm(),
          ),
        ],
      ),
    );
  }

  _buildForm() {
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
            lines: 20,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Content is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
