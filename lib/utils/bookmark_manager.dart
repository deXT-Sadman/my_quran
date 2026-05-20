import "dart:convert";
import "package:shared_preferences/shared_preferences.dart";

class BookmarkManager {
  static const String _key = "bookmarks";

  static Future<List<Map<String, dynamic>>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.cast<Map<String, dynamic>>();
  }

  static Future<void> addBookmark({
    required int surahNumber,
    required String surahName,
    required int ayahNumber,
    required String ayahText,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    bookmarks.add({
      'surahNumber': surahNumber,
      'surahName': surahName,
      'ayahNumber': ayahNumber,
      'ayahText': ayahText,
    });
    await prefs.setString(_key, jsonEncode(bookmarks));
  }

  static Future<void> removeBookmark(int surahNumber, int ayahNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    bookmarks.removeWhere(
      (b) => b['surahNumber'] == surahNumber && b['ayahNumber'] == ayahNumber,
    );
    await prefs.setString(_key, jsonEncode(bookmarks));
  }
}
