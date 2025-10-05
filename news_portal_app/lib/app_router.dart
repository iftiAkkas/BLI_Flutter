import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/home/home_page.dart';
import 'features/details/story_details_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/story/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return StoryDetailsPage(storyId: id);
      },
    ),
  ],
);
