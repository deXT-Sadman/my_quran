import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/surah.dart';

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
}
