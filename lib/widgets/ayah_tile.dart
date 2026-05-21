import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/ayah.dart';

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
              : const Color(0xFFD4AF37).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Top bar: actions (left) + verse number (right) ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: const Color(0xFFD4AF37),
                      size: 28,
                    ),
                    onPressed: onPlayTap,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: const Color(0xFFD4AF37),
                    ),
                    onPressed: onBookmarkTap,
                  ),
                ],
              ),
              // Verse number badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withOpacity(0.5),
                  ),
                ),
                child: Text(
                  '${ayah.numberInSurah}',
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Directionality(
            textDirection: TextDirection.rtl, // ← forces right-to-left
            child: Text(
              ayah.arabicText,
              textAlign: TextAlign.right,
              style: GoogleFonts.amiri(
                color: Colors.white,
                fontSize: 22,
                height: 2.0,
              ),
            ),
          ),

          if (showTranslation) ...[
            const Divider(color: Colors.white24, height: 24),
            Text(
              ayah.translation,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
