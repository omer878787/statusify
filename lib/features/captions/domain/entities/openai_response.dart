import 'package:json_annotation/json_annotation.dart';
import 'open_ai_output.dart';
part 'openai_response.g.dart';

@JsonSerializable()
class OpenAiResponse {
  final List<OpenAiOutput> output;

  OpenAiResponse({required this.output});

  factory OpenAiResponse.fromJson(Map<String, dynamic> json) =>
      _$OpenAiResponseFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$OpenAiResponseToJson(this);
}
