import 'package:flutter/material.dart';
import 'tabs/top_tab.dart';
import 'tabs/best_tab.dart';
import 'tabs/new_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hacker News Portal'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Top'),
              Tab(text: 'Best'),
              Tab(text: 'New'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TopStoriesTab(),
            BestStoriesTab(),
            NewStoriesTab(),
          ],
        ),
      ),
    );
  }
}
