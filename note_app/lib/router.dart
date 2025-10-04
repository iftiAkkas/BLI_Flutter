import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/add_note_page.dart';
import 'pages/edit_note_page.dart';
import 'settings_page.dart'; // ✅ Added missing import


final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomePage()),
      GoRoute(path: '/add', builder: (_, __) => const AddNotePage()),
      GoRoute(
        path: '/edit/:id',
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return EditNotePage(noteId: id);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsPage(),
      ),
    ],
  );
});
