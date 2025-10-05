import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/story_model.dart';

class HackerNewsApi {
  static const _base = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> fetchStoryIds(String category) async {
    final url = Uri.parse('$_base/$category.json?print=pretty');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> ids = jsonDecode(response.body);
      return ids.cast<int>();
    } else {
      throw Exception('Failed to load $category stories');
    }
  }

  Future<Story> fetchStory(int id) async {
    final url = Uri.parse('$_base/item/$id.json?print=pretty');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Story.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load story $id');
    }
  }
}
