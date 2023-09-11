import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// fonts
import 'package:google_fonts/google_fonts.dart';

// widgets
import 'package:meals_app/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amber, brightness: Brightness.dark),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() 
{
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget 
{
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
