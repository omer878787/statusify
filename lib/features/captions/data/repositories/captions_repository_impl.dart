import 'dart:convert';

import 'package:statusify/core/utils/emoji_decorator.dart';
import 'package:statusify/features/captions/data/datasources/captions_local_ds.dart';
import 'package:statusify/features/captions/data/datasources/openai_api.dart';
import 'package:statusify/features/captions/data/models/caption_model.dart';
import 'package:statusify/features/captions/domain/entities/caption.dart';
import 'package:statusify/features/captions/domain/entities/caption_filters.dart';
import 'package:statusify/features/captions/domain/repositories/captions_repository.dart';

class CaptionsRepositoryImpl implements CaptionsRepository {
  final CaptionsLocalDataSource local;
  final OpenAiApi openAiApi;

  CaptionsRepositoryImpl({required this.local, required this.openAiApi});

  @override
  Future<List<Caption>> getCaptions(CaptionFilters filters) async {
    final raw = await local.getCaptions(
      category: filters.category,
      language: filters.language,
      platform: filters.platform,
    );

    final decorated = raw
        .take(filters.count)
        .map((t) => decorateWithEmojis(t, filters.emojiStyle))
        .map((t) => CaptionModel.fromText(t))
        .toList();

    return decorated;
  }

  @override
  Future<List<Caption>> generateAiCaptions(CaptionFilters filters) async {
    final body = _buildOpenAiBody(filters);

    final res = await openAiApi.generateCaptions(body);

    final outputText = _extractOutputText(res);

    // Expecting JSON only:
    // { "captions": [ { "text": "..." }, ... ] }
    final decoded = jsonDecode(outputText) as Map<String, dynamic>;

    final captions = (decoded['captions'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map((e) => (e['text'] as String).trim())
        .where((t) => t.isNotEmpty)
        .take(filters.count)
        .map((t) => decorateWithEmojis(t, filters.emojiStyle))
        .map((t) => CaptionModel.fromText(t))
        .toList();

    return captions;
  }

  Map<String, dynamic> _buildOpenAiBody(CaptionFilters f) {
    final system = '''
You generate short social media captions.
Return ONLY valid JSON in this shape:
{"captions":[{"text":"..."},{"text":"..."}]}
No markdown, no extra keys, no commentary.
''';

    final user =
        '''
Generate ${f.count} captions.

Category/Occasion: ${f.category}
Platform: ${f.platform}
Language: ${f.language}
Tone/Style: default

Rules:
- Keep each caption short and punchy
- Avoid hashtags unless the platform typically uses them
- Do not include numbering like "1)" or "Caption:"
Return JSON only.
''';

    return {
      "model": "gpt-4.1-mini",
      "input": [
        {
          "role": "system",
          "content": [
            {"type": "input_text", "text": system},
          ],
        },
        {
          "role": "user",
          "content": [
            {"type": "input_text", "text": user},
          ],
        },
      ],
      "temperature": 0.8,
    };
  }

  String _extractOutputText(dynamic res) {
    // If your retrofit returns OpenAiResponse, type it as OpenAiResponse.
    // This function expects the Responses API structure:
    // output[] -> item.type == "message" -> content[] -> type == "output_text"
    final output = (res.output as List);

    final buffer = StringBuffer();
    for (final item in output) {
      if (item.type == 'message') {
        for (final c in item.content) {
          if (c.type == 'output_text' && c.text != null) {
            buffer.write(c.text);
          }
        }
      }
    }

    final text = buffer.toString().trim();

    if (text.isEmpty) {
      throw Exception('OpenAI returned empty output.');
    }

    // Sometimes models might wrap JSON with whitespace; that's fine.
    return text;
  }
}
