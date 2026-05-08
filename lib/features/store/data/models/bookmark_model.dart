import 'dart:convert';

class MyBookmark {
  final int productId;
  final String title;
  final String image;
  final double price;
  final String savedAt;

  MyBookmark({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'title': title,
    'image': image,
    'price': price,
    'savedAt': savedAt,
  };

  factory MyBookmark.fromJson(Map<String, dynamic> json) => MyBookmark(
    productId: json['productId'] as int,
    title: json['title'] as String,
    image: json['image'] as String,
    price: (json['price'] as num).toDouble(),
    savedAt: json['savedAt'] as String,
  );

  static String encodeList(List<MyBookmark> list) =>
      jsonEncode(list.map((b) => b.toJson()).toList());

  static List<MyBookmark> decodeList(String raw) {
    final List<dynamic> decoded = jsonDecode(raw);
    return decoded
        .map((e) => MyBookmark.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
