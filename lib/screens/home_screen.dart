import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import '../models/surah.dart';
import '../services/quran_service.dart';
import '../widgets/surah_card.dart';
import 'surah_detail_screen.dart';
import 'bookmarks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Surah>> _surahFuture;

  @override
  void initState() {
    super.initState();
    _surahFuture = QuranService.fetchAllSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: Text(
          "My Quran",
          style: GoogleFonts.amiri(
            color: Color(0xFFD4AF37),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark, color: Color(0xFFD4AF37)),
            onPressed: () {},
            //  => Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (_) => const BookmarksScreen()),
            // ),
          ),
        ],
      ),
      body: FutureBuilder<List<Surah>>(
        future: _surahFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Color(0xFFFF0000)),
              ),
            );
          }

          final surahs = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              return SurahCard(
                surah: surahs[index],
                onTap: () {},
                //  Navigator.push(context, MaterialPageRoute(builder: (_) => SurahDetailScreen(surah: surahs[index]),),),
              );
            },
          );
        },
      ),
    );
  }
}
