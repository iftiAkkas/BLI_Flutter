import 'dart:convert';
import 'dart:typed_data';

class Product {
  final int? id;
  final String name;
  final double price;
  final Uint8List? imageFile;
  final String? imageFileName;

  Product({
    this.id,
    required this.name,
    required this.price,
    this.imageFile,
    this.imageFileName,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image_file': imageFile != null ? base64Encode(imageFile!) : null,
      'image_filename': imageFileName,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    Uint8List? bytes;
    if (map['image_file'] != null) {
      try {
        bytes = base64Decode(map['image_file'] as String);
      } catch (e) {
        bytes = null;
      }
    }

    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      imageFile: bytes,
      imageFileName: map['image_filename'] as String?,
    );
  }
}
