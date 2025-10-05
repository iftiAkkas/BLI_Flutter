import 'package:flutter/material.dart';
import 'app_router.dart';
import 'core/db/sembast_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDb().init();
  runApp(const NewsPortalApp());
}

class NewsPortalApp extends StatelessWidget {
  const NewsPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'News Portal App',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
      ),
    );
  }
}
