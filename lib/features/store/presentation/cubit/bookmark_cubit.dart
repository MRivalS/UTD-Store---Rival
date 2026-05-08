import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../data/models/bookmark_model.dart';

class BookmarkCubit extends Cubit<List<MyBookmark>> {
  static const _key = 'bookmarks';

  BookmarkCubit() : super([]) {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null && raw.isNotEmpty) {
      emit(MyBookmark.decodeList(raw));
    }
  }

  Future<void> _saveBookmarks(List<MyBookmark> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, MyBookmark.encodeList(list));
  }

  Future<void> toggleBookmark(dynamic product) async {
    final current = List<MyBookmark>.from(state);
    final existingIndex = current.indexWhere((b) => b.productId == product.id);

    if (existingIndex != -1) {
      current.removeAt(existingIndex);
    } else {
      // Logika Personal (NIM Genap): timestamp waktu simpan
      final String timestamp = DateFormat('HH:mm').format(DateTime.now());
      current.add(
        MyBookmark(
          productId: product.id as int,
          title: product.title as String,
          image: product.image as String,
          price: (product.price as num).toDouble(),
          savedAt: timestamp,
        ),
      );
    }

    emit(current);
    await _saveBookmarks(current);
  }

  bool isBookmarked(int productId) =>
      state.any((b) => b.productId == productId);
}
