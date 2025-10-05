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
        body: SafeArea(child: Center(child: IDCardShape())),
      ),
    );
  }
}

class IDCardShape extends StatelessWidget {
  const IDCardShape({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final cardWidth = min(360.0, screenW * 0.86);
    final cardHeight = cardWidth * 1.65;

    // ✅ unified dark green
    const darkGreen = Color.fromARGB(255, 9, 43, 13); 

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
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(27)),
                    color: darkGreen,
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            'ISLAMIC UNIVERSITY OF TECHNOLOGY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
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
// Body
Expanded(
  child: Align(
    alignment: Alignment.topCenter, // center horizontally at the top
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 240), // max width of content block
      child: Padding(
        padding: const EdgeInsets.only(left: 50), // shift all contents slightly right
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // left-align children inside block
          mainAxisSize: MainAxisSize.min, // shrink to fit content
          children: [
            // ===== Student ID =====
            Padding(
              padding: const EdgeInsets.only(top: 85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.vpn_key, size: 20, color: Colors.black87),
                      SizedBox(width: 6),
                      Text(
                        "Student ID",
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(
                          width: 15,
                          height: 15,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "210041111",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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
                  decoration: const BoxDecoration(
                    color: darkGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 6),
                const Text(
                  "Student Name",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Name with slight right shift and larger font
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right:43), // push slightly left
                child: const Text(
                  "MD. IFTI AKKAS",
                  style: TextStyle(
                    fontSize: 17, // slightly larger
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== Program =====
            Row(
              children: const [
                Icon(Icons.school, size: 20, color: Colors.black87),
                SizedBox(width: 6),
                Text("Program:",
                    style: TextStyle(fontSize: 15, color: Colors.black54)),
                SizedBox(width: 6),
                Text(
                  "B.Sc. in CSE",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
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
                  decoration: const BoxDecoration(
                    color: darkGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.people, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 6),
                const Text(
                  "Department:",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                SizedBox(width: 6),
                const Text(
                  "CSE",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ===== Country =====
            Row(
              children: const [
                Icon(Icons.location_on, size: 20, color: Colors.black87),
                SizedBox(width: 6),
                Text(
                  "Bangladesh",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
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
                  decoration: const BoxDecoration(
                    color: darkGreen,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(27)),
                  ),
                  child: const Center(
                    child: Text(
                      'A subsidiary organ of OIC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Photo frame
          Positioned(
            top: cardHeight * 0.19,
            left: (cardWidth / 2) - 59,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: darkGreen,
                borderRadius: BorderRadius.circular(0),
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
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
