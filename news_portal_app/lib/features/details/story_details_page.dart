import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/api/hacker_news_api.dart';
import '../../core/models/story_model.dart';
import '../../core/db/sembast_db.dart'; // ✅ import your local DB

class StoryDetailsPage extends StatefulWidget {
  final int storyId;
  const StoryDetailsPage({super.key, required this.storyId});

  @override
  State<StoryDetailsPage> createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  final api = HackerNewsApi();
  final db = LocalDb();
  late Future<Story> storyFuture;

  @override
  void initState() {
    super.initState();
    storyFuture = _loadStory();
  }

  Future<Story> _loadStory() async {
    // ✅ First try to load from DB
    await db.init();
    final cached = await db.getStory(widget.storyId);

    try {
      // Try network
      final freshStory = await api.fetchStory(widget.storyId);
      // ✅ Save latest to local cache
      await db.insertStory(freshStory);
      return freshStory;
    } catch (e) {
      // ✅ Fallback to cached story
      if (cached != null) {
        debugPrint('⚠️ Network failed, showing cached data for ${widget.storyId}');
        return cached;
      }
      rethrow; // If no cache, show the actual error
    }
  }

  Future<List<Story>> fetchComments(List<int>? commentIds) async {
    if (commentIds == null || commentIds.isEmpty) return [];
    final futures = commentIds.map((id) => api.fetchStory(id));
    try {
      return await Future.wait(futures);
    } catch (_) {
      return []; // If offline, just show empty comment list
    }
  }

  Future<void> _launchUrl(String rawUrl, BuildContext context) async {
    if (rawUrl.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No URL provided')),
      );
      return;
    }

    Uri uri;
    try {
      uri = Uri.parse(rawUrl);
      if (uri.scheme.isEmpty) uri = Uri.parse('https://$rawUrl');
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid URL')),
      );
      return;
    }

    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open URL')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Story Details'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.deepOrange.withOpacity(0.3),
      ),
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
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Story card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  shadowColor: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title ?? 'No title',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (story.url != null && story.url!.isNotEmpty)
                          GestureDetector(
                            onTap: () => _launchUrl(story.url!, context),
                            child: Row(
                              children: [
                                const Icon(Icons.link, size: 18, color: Colors.blueAccent),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    story.url!,
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(Icons.open_in_new, size: 18, color: Colors.blueAccent),
                              ],
                            ),
                          )
                        else
                          const Text('No URL', style: TextStyle(color: Colors.grey)),

                        const SizedBox(height: 12),
                        Divider(color: Colors.grey.shade300),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(Icons.person, size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text('by ${story.by ?? 'unknown'}',
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.thumb_up_alt_rounded,
                                size: 18, color: Colors.orangeAccent),
                            const SizedBox(width: 6),
                            Text('Score: ${story.score ?? 0}',
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.confirmation_number,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text('ID: ${story.id}', style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  'Comments',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                const SizedBox(height: 8),

                if (story.kids == null || story.kids!.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No comments', style: TextStyle(color: Colors.grey)),
                  )
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
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              title: Text(
                                comment.text ?? '[deleted]',
                                style: const TextStyle(fontSize: 14, color: Colors.black87),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'by ${comment.by ?? 'unknown'}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
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
