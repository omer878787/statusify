import 'dart:math';

final _packs = <String, List<String>>{
  "none": [],
  "eid": ["🌙", "✨", "🕌", "🤲", "💛"],
  "hearts": ["❤️", "💕", "💖", "😍"],
  "funny": ["😂", "🤣", "😜", "🙃"],
  "simple": ["✨", "😊", "🌸", "🌙"],
};

String decorateWithEmojis(String text, String style) {
  final emojis = _packs[style] ?? [];
  if (emojis.isEmpty) return text;

  final r = Random();
  final e1 = emojis[r.nextInt(emojis.length)];
  final e2 = emojis[r.nextInt(emojis.length)];
  return "$e1 $text $e2";
}
