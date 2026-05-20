import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../models/ayah.dart";

class AyahTile extends StatelessWidget {
  final Ayah ayah;
  final bool showTranslation;
  final bool isPlaying;
  final bool isBookmarked;
  final VoidCallback onPlayTap;
  final VoidCallback onBookmarkTap;

  const AyahTile({
    super.key,
    required this.ayah,
    required this.showTranslation,
    required this.isPlaying,
    required this.isBookmarked,
    required this.onPlayTap,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: onPlayTap,
                    icon: Icon(
                      isPlaying ? Icons.stop : Icons.play_arrow,
                      color: const Color(0xFFD4AF37),
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: onBookmarkTap,
                    icon: Icon(
                      Icons.bookmark_border,
                      color: const Color(0xFFD4AF37),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${ayah.numberInSurah}",
                      style: GoogleFonts.lato(
                        color: const Color(0xFFD4AF37),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                ayah.arabicText,
                textAlign: TextAlign.right,
                style: GoogleFonts.amiri(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  height: 2.0,
                ),
              ),
              if (showTranslation) ...[
                const Divider(color: Colors.white24, height: 24),
                Text(
                  ayah.translation,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.lato(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
