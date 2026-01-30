// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAiResponse _$OpenAiResponseFromJson(Map<String, dynamic> json) =>
    OpenAiResponse(
      output: (json['output'] as List<dynamic>)
          .map((e) => OpenAiOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpenAiResponseToJson(OpenAiResponse instance) =>
    <String, dynamic>{'output': instance.output};
