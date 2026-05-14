class Surah {
  final int number; // ← int, not String
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs; // ← int, not String
  final String revelationType;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'] as int, // ← add 'as int'
      name: json['name'] as String,
      englishName: json['englishName'] as String,
      englishNameTranslation: json['englishNameTranslation'] as String,
      numberOfAyahs: json['numberOfAyahs'] as int, // ← add 'as int'
      revelationType: json['revelationType'] as String,
    );
  }
}
