import 'package:flutter/material.dart';
import '../../core/api/hacker_news_api.dart';
import '../../core/models/story_model.dart';

class StoryDetailsPage extends StatefulWidget {
  final int storyId;
  const StoryDetailsPage({super.key, required this.storyId});

  @override
  State<StoryDetailsPage> createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  final api = HackerNewsApi();
  late Future<Story> storyFuture;

  @override
  void initState() {
    super.initState();
    storyFuture = api.fetchStory(widget.storyId);
  }

  Future<List<Story>> fetchComments(List<int>? commentIds) async {
    if (commentIds == null || commentIds.isEmpty) return [];
    final comments = <Story>[];
    for (final id in commentIds) {
      comments.add(await api.fetchStory(id));
    }
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Story Details')),
      body: FutureBuilder<Story>(
        future: storyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final story = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Story title
                Text(
                  story.title ?? 'No title',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),

                // Story URL
                if (story.url != null)
                  TextButton(
                    onPressed: () {
                      // TODO: Open URL using url_launcher
                    },
                    child: Text(story.url ?? 'No URL'),
                  ),
                const SizedBox(height: 8),

                // Story info
                Text('by ${story.by ?? 'unknown'}'),
                Text('Score: ${story.score ?? 0}'),
                Text('ID: ${story.id ?? 0}'),

                // Comments section
                const SizedBox(height: 16),
                Text(
                  'Comments:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (story.kids == null || story.kids!.isEmpty)
                  const Text('No comments')
                else
                  FutureBuilder<List<Story>>(
                    future: fetchComments(story.kids),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error loading comments: ${snapshot.error}');
                      }
                      final comments = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: comments.map((comment) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'by ${comment.by ?? 'unknown'}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(comment.text ?? '[deleted]'),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
