import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ChecklyApp());
}

class ChecklyApp extends StatelessWidget {
  final StorageService? storage;
  const ChecklyApp({super.key, this.storage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF3B82F6),
        scaffoldBackgroundColor: Colors.white, // Changed to White
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          primary: const Color(0xFF3B82F6),
          surface: Colors.white,
          onSurface: const Color(0xFF1E293B),
        ),
        textTheme: GoogleFonts.dmSansTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: HomeScreen(storage: storage),
    );
  }
}
