import 'dart:convert';
import 'package:flutter/services.dart';

class CaptionsLocalDataSource {
  Future<List<String>> getCaptions({
    required String category,
    required String language,
    required String platform,
  }) async {
    final raw = await rootBundle.loadString('assets/captions.json');
    final Map<String, dynamic> decoded = jsonDecode(raw);

    final list = decoded[category]?[language]?[platform];
    if (list is List) return List<String>.from(list);

    return [];
  }
}
