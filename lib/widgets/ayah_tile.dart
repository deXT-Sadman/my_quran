import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../models/ayah.dart";

class AyahTile extends StatelessWidget {
  final Ayah ayah;
  final bool showTranslation;
  final bool isPlaying;
  final bool isBookmarked;
  final VoidCallback onPlay;
  final VoidCallback onBookmarkTap;

  const AyahTile({
    super.key,
    required this.ayah,
    required this.showTranslation,
    required this.isPlaying,
    required this.isBookmarked,
    required this.onPlay,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3A4B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPlaying
              ? const Color(0xFFD4AF37)
              : Color(0xFFD4AF37).withValues(alpha: 0.5),
          width: 2,
        ),
      ),
    );
  }
}
