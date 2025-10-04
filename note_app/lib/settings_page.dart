import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_mode.dart';
import 'font_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final font = ref.watch(fontProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Theme", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Light"),
                Radio<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(themeProvider.notifier).setTheme(value);
                    }
                  },
                ),
                const Text("Dark"),
                Radio<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(themeProvider.notifier).setTheme(value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Font", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ...fonts.map(
              (f) => RadioListTile<String>(
                title: Text(f),
                value: f,
                groupValue: font,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(fontProvider.notifier).setFont(value);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
