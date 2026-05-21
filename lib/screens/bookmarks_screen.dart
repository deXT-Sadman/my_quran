import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/bookmark_manager.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Map<String, dynamic>> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bm = await BookmarkManager.getBookmarks();
    setState(() => _bookmarks = bm);
  }

  Future<void> _removeBookmark(Map<String, dynamic> bm) async {
    await BookmarkManager.removeBookmark(bm['surahNumber'], bm['ayahNumber']);
    await _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B3A4B),
        title: Text(
          "Bookmarks",
          style: GoogleFonts.amiri(
            color: const Color(0xFFD4AF37),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _bookmarks.isEmpty
          ? const Center(
              child: Text(
                "No bookmarks yet.",
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(26),
              itemCount: _bookmarks.length,
              itemBuilder: (context, index) {
                final bm = _bookmarks[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B3A4B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${bm['surahName']}-Ayah ${bm['ayahNumber']}',
                              style: const TextStyle(
                                color: Color(0xFFD4AF37),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              bm['ayahText'],
                              style: GoogleFonts.amiri(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeBookmark(bm),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
