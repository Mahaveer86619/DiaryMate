import 'package:diary_mate/common/routes/app_routes.dart';
import 'package:diary_mate/common/widgets/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:diary_mate/core/themes/theme.dart';
import 'package:diary_mate/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:diary_mate/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.registerDependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => di.sl<NavigationBloc>(),
        ),
        BlocProvider<DiaryBloc>(
          create: (context) => di.sl<DiaryBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'DiaryMate',
        theme: darkMode,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
