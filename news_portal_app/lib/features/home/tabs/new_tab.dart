import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/api/hacker_news_api.dart';
import '../../../core/models/story_model.dart';

class NewStoriesTab extends StatefulWidget {
  const NewStoriesTab({super.key});

  @override
  State<NewStoriesTab> createState() => _NewStoriesTabState();
}

class _NewStoriesTabState extends State<NewStoriesTab> {
  final api = HackerNewsApi();
  late Future<List<Story>> storiesFuture;

  @override
  void initState() {
    super.initState();
    storiesFuture = loadStories();
  }

  Future<List<Story>> loadStories() async {
    final ids = await api.fetchStoryIds('newstories');
    final first20 = ids.take(20);
    final stories = <Story>[];
    for (final id in first20) {
      stories.add(await api.fetchStory(id));
    }
    return stories;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Story>>(
      future: storiesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final stories = snapshot.data!;
        return ListView.builder(
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return ListTile(
              title: Text(story.title ?? 'No title'), // null-safe
              subtitle: Text(
                  'by ${story.by ?? 'unknown'} • ${story.score ?? 0} points'), // null-safe
              onTap: () {
                context.push('/story/${story.id ?? 0}'); // fallback if id is null
              },
            );
          },
        );
      },
    );
  }
}
