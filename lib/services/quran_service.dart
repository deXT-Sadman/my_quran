import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/surah.dart';
import '../models/ayah.dart';

class QuranService {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  static Future<List<Surah>> fetchAllSurahs() async {
    final response = await http.get(Uri.parse('$_baseUrl/surah'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List surahList = data['data'];
      return surahList.map((json) => Surah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load surahs');
    }
  }

  static Future<List<Ayah>> fetchSurahDetail(int surahNumber) async {
    final url =
        '$_baseUrl/surah/$surahNumber/editions/quran-simple,en.asad,ar.alafasy';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final edition = data['data'] as List;

      final arabicAyahs = edition[0]['ayahs'] as List;
      final translationAyahs = edition[1]['ayahs'] as List;
      final audioAyahs = edition[2]['ayahs'] as List;

      return List.generate(arabicAyahs.length, (i) {
        return Ayah(
          numberInSurah: arabicAyahs[i]['numberInSurah'],
          arabicText: arabicAyahs[i]['text'],
          translation: translationAyahs[i]['text'],
          audioUrl: audioAyahs[i]['audio'],
        );
      });
    } else {
      throw Exception('Failed to load surah details');
    }
  }
}
