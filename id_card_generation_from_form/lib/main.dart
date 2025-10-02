// lib/main.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ID Card Generator',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const IDCardFormPage(),
    );
  }
}

class IDCardFormPage extends StatefulWidget {
  const IDCardFormPage({super.key});

  @override
  State<IDCardFormPage> createState() => _IDCardFormPageState();
}

class _IDCardFormPageState extends State<IDCardFormPage> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _programController = TextEditingController();
  final _departmentController = TextEditingController();
  final _countryController = TextEditingController();

  bool _showCard = false;
  Uint8List? _pickedImage;

  Future<void> _pickFileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _pickedImage = result.files.single.bytes!;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _programController.dispose();
    _departmentController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color.fromARGB(255, 9, 43, 13);
    const formWidth = 380.0;

    final cardWidth = 360.0;
    final cardHeight = cardWidth * 1.65;

    return Scaffold(
      backgroundColor: const Color(0xFFE9F3F1),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: formWidth,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 12)
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "ID Card Generator",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                ElevatedButton.icon(
                  onPressed: _pickFileImage,
                  icon: const Icon(Icons.file_open),
                  label: const Text("Pick Your Photo File"),
                ),
                const SizedBox(height: 12),

                if (_pickedImage != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(_pickedImage!),
                  ),
                const SizedBox(height: 12),

                // Form fields
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                      labelText: "Student ID", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: "Student Name", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _programController,
                  decoration: const InputDecoration(
                      labelText: "Program", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                      labelText: "Department", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                      labelText: "Country", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    if (_pickedImage != null &&
                        _nameController.text.isNotEmpty &&
                        _idController.text.isNotEmpty) {
                      setState(() {
                        _showCard = true;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Please pick a photo and fill required fields")),
                      );
                    }
                  },
                  child: const Text("Generate ID Card"),
                ),
                const SizedBox(height: 24),

                // ID Card Display
                if (_showCard)
                  SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(27),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 12,
                                  offset: Offset(0, 8))
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
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(0, -20),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Text(
                                          'ISLAMIC UNIVERSITY OF TECHNOLOGY',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 85),

                                          // Student ID
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: const [
                                                  Icon(Icons.vpn_key,
                                                      size: 20,
                                                      color: Colors.black87),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    "Student ID",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: darkGreen,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 6),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                      _idController.text,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),

                                          // Student Name
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(2),
                                                decoration: const BoxDecoration(
                                                  color: darkGreen,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.person,
                                                    size: 18,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(width: 6),
                                              const Text(
                                                "Student Name",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 43),
                                              child: Text(
                                                _nameController.text,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: darkGreen),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),

                                          // Program
                                          Row(
                                            children: [
                                              const Icon(Icons.school,
                                                  size: 20, color: Colors.black87),
                                              const SizedBox(width: 6),
                                              const Text(
                                                "Program:",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                _programController.text,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: darkGreen),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),

                                          // Department
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(2),
                                                decoration: const BoxDecoration(
                                                  color: darkGreen,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.people,
                                                    size: 18,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(width: 6),
                                              const Text(
                                                "Department:",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                _departmentController.text,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: darkGreen),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),

                                          // Country
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on,
                                                  size: 20, color: Colors.black87),
                                              const SizedBox(width: 6),
                                              Text(
                                                _countryController.text,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: darkGreen),
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
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(27)),
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

                        // Photo frame (double border)
                        Positioned(
                          top: cardHeight * 0.19,
                          left: (cardWidth / 2) - 64,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: darkGreen, // outer border
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 3))
                              ],
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white, // inner background
                                borderRadius: BorderRadius.circular(0),
                                image: _pickedImage != null
                                    ? DecorationImage(
                                        image: MemoryImage(_pickedImage!),
                                        fit: BoxFit.cover)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
