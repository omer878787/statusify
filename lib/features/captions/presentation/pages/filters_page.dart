import 'package:flutter/material.dart';
import '../../domain/entities/caption_filters.dart';
import 'package:go_router/go_router.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  String category = "eid";
  String language = "en";
  String platform = "whatsapp";
  String emojiStyle = "eid";

  final categories = const [
    // Religious & Events
    "eid",
    "ramadan",
    "jummah",
    "islamic",
    "durood",

    // Love & Emotions
    "love",
    "romantic",
    "sad",
    "heartbreak",
    "missing",
    "emotional",

    // Poetry & Literature
    "poetry",
    "shayari",
    "urdu_poetry",
    "english_poetry",
    "ghazal",

    // Motivation & Life
    "motivational",
    "inspirational",
    "life",
    "success",
    "positive",
    "self_growth",

    // Social & Attitude
    "attitude",
    "alone",
    "fake_people",
    "truth",
    "reality",

    // Fun & Casual
    "funny",
    "sarcastic",
    "mood",
    "chill",
    "weekend",

    // Friendship & Family
    "friendship",
    "best_friend",
    "family",
    "brother",
    "sister",

    // Social Media Ready
    "instagram",
    "whatsapp",
    "facebook",
    "short_status",
  ];

  final languages = const [
    // Global
    "en", // English
    // South Asia
    "ur", // Urdu
    "hi", // Hindi
    "bn", // Bengali
    "pa", // Punjabi
    "ps", // Pashto
    "sd", // Sindhi
    "gu", // Gujarati
    "ta", // Tamil
    // Middle East
    "ar", // Arabic
    "fa", // Persian (Farsi)
    // Europe
    "tr", // Turkish
    "es", // Spanish
    "fr", // French
    // East / Global
    "id", // Indonesian
    "ms", // Malay
  ];

  final platforms = const [
    // Messaging Apps
    "whatsapp",
    "telegram",
    "signal",

    // Social Media
    "instagram",
    "facebook",
    "threads",
    "snapchat",

    // Short-form & Trendy
    "tiktok",
    "twitter", // (X)
    "youtube", // Shorts / Community posts
    // Professional & Public
    "linkedin",

    // General / Fallback
    "story",
    "bio",
    "status",
  ];

  final emojiStyles = const [
    // Basic
    "none",
    "simple",

    // Love & Emotions
    "hearts",
    "romantic",
    "sad",
    "broken",

    // Religious / Events
    "eid",
    "ramadan",
    "islamic",

    // Fun & Casual
    "funny",
    "sarcastic",
    "playful",

    // Motivation & Attitude
    "motivational",
    "success",
    "attitude",

    // Social / Aesthetic
    "aesthetic",
    "minimal",
    "bold",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generate Status")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _dd(
              "Category",
              category,
              categories,
              (v) => setState(() => category = v),
            ),
            _dd(
              "Language",
              language,
              languages,
              (v) => setState(() => language = v),
            ),
            _dd(
              "Platform",
              platform,
              platforms,
              (v) => setState(() => platform = v),
            ),
            _dd(
              "Emoji Style",
              emojiStyle,
              emojiStyles,
              (v) => setState(() => emojiStyle = v),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {
                  final filters = CaptionFilters(
                    category: category,
                    language: language,
                    platform: platform,
                    emojiStyle: emojiStyle,
                    count: 30,
                  );
                  context.pushNamed('results', extra: filters);
                },
                child: const Text("Show Results"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dd(
    String label,
    String value,
    List<String> items,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) => onChanged(v!),
      ),
    );
  }
}
