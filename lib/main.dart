import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock dark system overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0D10),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const AutoVerseApp());
}

class AutoVerseApp extends StatelessWidget {
  const AutoVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoVerse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainShell(),
    );
  }
}
