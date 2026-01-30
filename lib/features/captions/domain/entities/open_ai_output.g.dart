// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_ai_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAiOutput _$OpenAiOutputFromJson(Map<String, dynamic> json) => OpenAiOutput(
  type: json['type'] as String,
  content: (json['content'] as List<dynamic>)
      .map((e) => OpenAiContent.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OpenAiOutputToJson(OpenAiOutput instance) =>
    <String, dynamic>{'type': instance.type, 'content': instance.content};
