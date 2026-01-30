import 'package:json_annotation/json_annotation.dart';
import 'open_ai_content.dart';
part 'open_ai_output.g.dart';

@JsonSerializable()
class OpenAiOutput {
  final String type;
  final List<OpenAiContent> content;

  OpenAiOutput({required this.type, required this.content});

  factory OpenAiOutput.fromJson(Map<String, dynamic> json) =>
      _$OpenAiOutputFromJson(json);
  Map<String, dynamic> toJson() => _$OpenAiOutputToJson(this);
}
