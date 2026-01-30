import 'package:json_annotation/json_annotation.dart';

part 'open_ai_content.g.dart';

@JsonSerializable()
class OpenAiContent {
  final String type;
  final String? text;

  OpenAiContent({required this.type, this.text});

  factory OpenAiContent.fromJson(Map<String, dynamic> json) =>
      _$OpenAiContentFromJson(json);
  Map<String, dynamic> toJson() => _$OpenAiContentToJson(this);
}
