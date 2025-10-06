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
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          title: const Text(
            'Hacker News Portal',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              unselectedLabelColor: Colors.white70,
              labelColor: Colors.white,
              tabs: [
                Tab(text: '🔥 Top'),
                Tab(text: '⭐ Best'),
                Tab(text: '🆕 New'),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFE0B2),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              TopStoriesTab(),
              BestStoriesTab(),
              NewStoriesTab(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Fetching latest stories...'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
      ),
    );
  }
}