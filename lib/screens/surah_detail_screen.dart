import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/surah.dart';
import '../models/ayah.dart';
import '../services/quran_service.dart';
import '../utils/bookmark_manager.dart';
import '../widgets/ayah_tile.dart';

class SurahDetailScreen extends StatefulWidget {
  final Surah surah;
  const SurahDetailScreen({super.key, required this.surah});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late Future<List<Ayah>> _ayahFuture;
  bool _showTranslation = true;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _playingIndex;
  Set<int> _bookmarkedAyahs = {};

  @override
  void initState() {
    super.initState();
    _ayahFuture = QuranService.fetchSurahDetail(widget.surah.number);
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await BookmarkManager.getBookmarks();
    setState(() {
      _bookmarkedAyahs = bookmarks
          .where((b) => b['surahNumber'] == widget.surah.number)
          .map((b) => b['ayahNumber'] as int)
          .toSet();
    });
  }

  Future<void> _playAudio(String url, int index) async {
    if (_playingIndex == index) {
      await _audioPlayer.stop();
      setState(() => _playingIndex = null);
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
      setState(() => _playingIndex = index);
    }
  }

  Future<void> _toggleBookmark(Ayah ayah) async {
    final isBookmarked = _bookmarkedAyahs.contains(ayah.numberInSurah);
    if (isBookmarked) {
      await BookmarkManager.removeBookmark(
        widget.surah.number,
        ayah.numberInSurah,
      );
    } else {
      await BookmarkManager.addBookmark(
        surahNumber: widget.surah.number,
        surahName: widget.surah.englishName,
        ayahNumber: ayah.numberInSurah,
        ayahText: ayah.arabicText,
      );
    }
    await _loadBookmarks();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B3A4B),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.surah.englishName,
              style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 18),
            ),
            Text(
              widget.surah.englishNameTranslation,
              style: TextStyle(color: Colors.white30, fontSize: 12),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              const Text(
                "TR",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Switch(
                value: _showTranslation,
                activeThumbColor: const Color(
                  0xFFD4AF37,
                ), // thumb (circle) color
                activeTrackColor: const Color(
                  0xFFD4AF37,
                ).withValues(alpha: 0.4), // track (bar) color
                inactiveThumbColor: Colors.white54, // thumb when OFF
                inactiveTrackColor: Colors.white24, // track when OFF
                onChanged: (value) {
                  setState(() {
                    _showTranslation = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: _ayahFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          final ayahs = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ayahs.length,
            itemBuilder: (context, index) {
              final ayah = ayahs[index];
              return AyahTile(
                ayah: ayah,
                showTranslation: _showTranslation,
                isPlaying: _playingIndex == index,
                isBookmarked: _bookmarkedAyahs.contains(ayah.numberInSurah),
                onPlayTap: () => _playAudio(ayah.audioUrl, index),
                onBookmarkTap: () => _toggleBookmark(ayah),
              );
            },
          );
        },
      ),
    );
  }
}
