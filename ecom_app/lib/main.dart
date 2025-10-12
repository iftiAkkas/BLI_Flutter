import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth/login_page.dart';
import 'core/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pmxyeihahwudrrgczkou.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBteHllaWhhaHd1ZHJyZ2N6a291Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3MzEzNTUsImV4cCI6MjA3NTMwNzM1NX0.5BC6IcPLY7rAr2cFAG4T-vBkXU7sYXo5lg8xIubSjkw',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
