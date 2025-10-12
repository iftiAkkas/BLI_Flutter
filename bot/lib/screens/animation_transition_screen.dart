import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'chat_history_screen.dart';

class AnimationTransitionScreen extends StatefulWidget {
  const AnimationTransitionScreen({super.key});

  @override
  State<AnimationTransitionScreen> createState() =>
      _AnimationTransitionScreenState();
}

class _AnimationTransitionScreenState
    extends State<AnimationTransitionScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHistory();
  }

  Future<void> _navigateToHistory() async {
    await Future.delayed(const Duration(seconds: 2)); // adjust time
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ChatHistoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand( // fullscreen
        child: RiveAnimation.asset(
          'assets/animations/bot.riv',
          fit: BoxFit.cover, // fills whole screen
        ),
      ),
    );
  }
}
