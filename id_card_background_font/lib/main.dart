// lib/main.dart
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ID Card Shape Demo',
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        backgroundColor: Color(0xFFE9F3F1),
        body: SafeArea(child: Center(child: IDCardWithButton())),
      ),
    );
  }
}

class IDCardWithButton extends StatefulWidget {
  const IDCardWithButton({super.key});

  @override
  State<IDCardWithButton> createState() => _IDCardWithButtonState();
}

class _IDCardWithButtonState extends State<IDCardWithButton> {
  // 🎨 Multiple colors to cycle through
  final List<Color> colors = [
    const Color.fromARGB(255, 9, 43, 13), // dark green
    Colors.indigo,
    Colors.deepOrange,
    Colors.teal,
  ];
  int colorIndex = 0;

  // 🔤 Font styles to cycle through
  final List<TextStyle> fontStyles = [
    const TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
    const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
    const TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
    const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
  ];
  int styleIndex = 0;

  void _toggleColor() {
    setState(() {
      colorIndex = (colorIndex + 1) % colors.length;
    });
  }

  void _toggleFontStyle() {
    setState(() {
      styleIndex = (styleIndex + 1) % fontStyles.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IDCardShape(
          cardColor: colors[colorIndex],
          textStyle: fontStyles[styleIndex],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _toggleColor,
          child: const Text("Change Card Color"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _toggleFontStyle,
          child: const Text("Change Font Style"),
        ),
      ],
    );
  }
}

class IDCardShape extends StatelessWidget {
  final Color cardColor;
  final TextStyle textStyle;
  const IDCardShape({super.key, required this.cardColor, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final cardWidth = min(360.0, screenW * 0.86);
    final cardHeight = cardWidth * 1.65;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main rounded card background
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(27),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  height: cardHeight * 0.28,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(27)),
                    color: cardColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -28),
                        child: Image.asset(
                          "assets/iut_logo.png",
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            'ISLAMIC UNIVERSITY OF TECHNOLOGY',
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Body
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 240),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ===== Student ID =====
                            Padding(
                              padding: const EdgeInsets.only(top: 85),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.vpn_key,
                                          size: 20, color: Colors.black87),
                                      const SizedBox(width: 6),
                                      Text("Student ID",
                                          style: textStyle.copyWith(
                                              fontSize: 14,
                                              color: Colors.black54)),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "210041111",
                                          style: textStyle.copyWith(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // ===== Student Name =====
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.person,
                                      size: 18, color: Colors.white),
                                ),
                                const SizedBox(width: 6),
                                Text("Student Name",
                                    style: textStyle.copyWith(
                                        fontSize: 14, color: Colors.black54)),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 43),
                                child: Text(
                                  "MD. IFTI AKKAS",
                                  style: textStyle.copyWith(
                                    fontSize: 18,
                                    color: cardColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // ===== Program =====
                            Row(
                              children: [
                                const Icon(Icons.school,
                                    size: 20, color: Colors.black87),
                                const SizedBox(width: 6),
                                Text("Program:",
                                    style: textStyle.copyWith(
                                        fontSize: 14, color: Colors.black54)),
                                const SizedBox(width: 6),
                                Text(
                                  "B.Sc. in CSE",
                                  style: textStyle.copyWith(
                                    fontSize: 14,
                                    color: cardColor,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // ===== Department =====
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.people,
                                      size: 18, color: Colors.white),
                                ),
                                const SizedBox(width: 6),
                                Text("Department:",
                                    style: textStyle.copyWith(
                                        fontSize: 14, color: Colors.black54)),
                                const SizedBox(width: 6),
                                Text("CSE",
                                    style: textStyle.copyWith(
                                        fontSize: 14, color: cardColor)),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // ===== Country =====
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 20, color: Colors.black87),
                                const SizedBox(width: 6),
                                Text(
                                  "Bangladesh",
                                  style: textStyle.copyWith(
                                    fontSize: 14,
                                    color: cardColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom strip
                Container(
                  height: cardHeight * 0.09,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(27)),
                  ),
                  child: Center(
                    child: Text(
                      'A subsidiary organ of OIC',
                      style: textStyle.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Photo frame with green border
          Positioned(
            top: cardHeight * 0.19,
            left: (cardWidth / 2) - 59,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/ifti.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

