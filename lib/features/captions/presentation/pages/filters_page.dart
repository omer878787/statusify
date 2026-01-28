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

  final categories = const ["eid", "love"];
  final languages = const ["en", "ur"];
  final platforms = const ["whatsapp", "instagram"];
  final emojiStyles = const ["none", "simple", "eid", "hearts", "funny"];

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
                    count: 10,
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
