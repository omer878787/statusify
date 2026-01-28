import 'package:json_annotation/json_annotation.dart';

part 'caption_filters.g.dart';

@JsonSerializable()
class CaptionFilters {
  final String category; // eid, love...
  final String language; // en, ur
  final String platform; // whatsapp, instagram...
  final String emojiStyle; // none, eid, hearts...
  final int count;

  const CaptionFilters({
    required this.category,
    required this.language,
    required this.platform,
    required this.emojiStyle,
    this.count = 10,
  });

  /// from json
  factory CaptionFilters.fromJson(Map<String, dynamic> json) =>
      _$CaptionFiltersFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$CaptionFiltersToJson(this);
}
